import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";

import { useCurrentWorkspaceId } from "area/workspace/utils";
import { isDefined } from "core/utils/common";
import { trackError } from "core/utils/datadog";

import { connectorDefinitionKeys } from "./connectorUpdates";
import {
  createCustomDestinationDefinition,
  deleteDestinationDefinition,
  getDestinationDefinitionForWorkspace,
  listDestinationDefinitionsForWorkspace,
  listDestinationDefinitions,
  listLatestDestinationDefinitions,
  updateDestinationDefinition,
} from "../generated/AirbyteClient";
import { SCOPE_WORKSPACE } from "../scopes";
import {
  DestinationDefinitionCreate,
  DestinationDefinitionIdRequestBody,
  DestinationDefinitionRead,
  DestinationDefinitionReadList,
} from "../types/AirbyteClient";
import { useRequestOptions } from "../useRequestOptions";
import { useSuspenseQuery } from "../useSuspenseQuery";

export const destinationDefinitionKeys = {
  all: [SCOPE_WORKSPACE, "destinationDefinition"] as const,
  lists: (filterByUsed: boolean = false) => [...destinationDefinitionKeys.all, "list", filterByUsed] as const,
  listLatest: () => [...destinationDefinitionKeys.all, "listLatest"] as const,
  detail: (id: string) => [...destinationDefinitionKeys.all, "details", id] as const,
};

/**
 * This hook calls the list_latest endpoint, which is not needed under most circumstances. Only use this hook if you need the latest destination definitions available, for example when prompting the user to update a connector version.
 */
export const useLatestDestinationDefinitionList = (): DestinationDefinitionReadList => {
  const requestOptions = useRequestOptions();

  return useSuspenseQuery(
    destinationDefinitionKeys.listLatest(),
    () => listLatestDestinationDefinitions(requestOptions),
    { staleTime: 60_000 }
  );
};

interface DestinationDefinitions {
  destinationDefinitions: DestinationDefinitionRead[];
  destinationDefinitionMap: Map<string, DestinationDefinitionRead>;
}

export const useDestinationDefinitionList = ({
  filterByUsed,
}: { filterByUsed?: boolean } = {}): DestinationDefinitions => {
  const requestOptions = useRequestOptions();

  const workspaceId = useCurrentWorkspaceId();

  return useQuery(
    destinationDefinitionKeys.lists(filterByUsed),
    async () => {
      const { destinationDefinitions } = await listDestinationDefinitionsForWorkspace(
        { workspaceId, filterByUsed },
        requestOptions
      ).then(({ destinationDefinitions }) => ({
        destinationDefinitions: destinationDefinitions.sort((a, b) => a.name.localeCompare(b.name)),
      }));
      const destinationDefinitionMap = new Map<string, DestinationDefinitionRead>();
      destinationDefinitions.forEach((destinationDefinition) => {
        destinationDefinitionMap.set(destinationDefinition.destinationDefinitionId, destinationDefinition);
      });
      return {
        destinationDefinitions,
        destinationDefinitionMap,
      };
    },
    { suspense: true }
  ).data as DestinationDefinitions;
};

export const useDestinationDefinition = <T extends string | undefined>(
  destinationDefinitionId: T
): T extends string ? DestinationDefinitionRead : DestinationDefinitionRead | undefined => {
  const requestOptions = useRequestOptions();
  const workspaceId = useCurrentWorkspaceId();

  return useSuspenseQuery(
    destinationDefinitionKeys.detail(destinationDefinitionId || ""),
    () =>
      getDestinationDefinitionForWorkspace(
        { workspaceId, destinationDefinitionId: destinationDefinitionId || "" },
        requestOptions
      ),
    {
      enabled: isDefined(destinationDefinitionId),
    }
  );
};

export const useCreateDestinationDefinition = () => {
  const requestOptions = useRequestOptions();
  const queryClient = useQueryClient();
  const workspaceId = useCurrentWorkspaceId();

  return useMutation<DestinationDefinitionRead, Error, DestinationDefinitionCreate>(
    (destinationDefinition) =>
      createCustomDestinationDefinition({ workspaceId, destinationDefinition }, requestOptions),
    {
      onSuccess: (data) => {
        queryClient.setQueryData(destinationDefinitionKeys.lists(), (oldData: DestinationDefinitions | undefined) => {
          const newMap = new Map(oldData?.destinationDefinitionMap);
          newMap.set(data.destinationDefinitionId, data);
          return {
            destinationDefinitions: [data, ...(oldData?.destinationDefinitions ?? [])],
            destinationDefinitionMap: newMap,
          };
        });
      },
    }
  );
};

export const useUpdateDestinationDefinition = () => {
  const requestOptions = useRequestOptions();
  const queryClient = useQueryClient();
  const workspaceId = useCurrentWorkspaceId();

  return useMutation<
    DestinationDefinitionRead,
    Error,
    {
      destinationDefinitionId: string;
      dockerImageTag: string;
    }
  >((destinationDefinition) => updateDestinationDefinition({ ...destinationDefinition, workspaceId }, requestOptions), {
    onSuccess: (data) => {
      queryClient.setQueryData(destinationDefinitionKeys.detail(data.destinationDefinitionId), data);

      queryClient.setQueryData(destinationDefinitionKeys.lists(), (oldData: DestinationDefinitions | undefined) => {
        const newMap = new Map(oldData?.destinationDefinitionMap);
        newMap.set(data.destinationDefinitionId, data);
        return {
          destinationDefinitions:
            oldData?.destinationDefinitions.map((dd) =>
              dd.destinationDefinitionId === data.destinationDefinitionId ? data : dd
            ) ?? [],
          destinationDefinitionMap: newMap,
        };
      });

      queryClient.invalidateQueries(connectorDefinitionKeys.count());
    },
    onError: (error: Error) => {
      trackError(error);
    },
  });
};

export const useDeleteDestinationDefinition = () => {
  const requestOptions = useRequestOptions();
  const queryClient = useQueryClient();

  const { mutateAsync } = useMutation(
    (body: DestinationDefinitionIdRequestBody) => deleteDestinationDefinition(body, requestOptions).then(() => body),
    {
      onSuccess: (body) => {
        queryClient.setQueryData(destinationDefinitionKeys.detail(body.destinationDefinitionId), undefined);
        queryClient.setQueryData(destinationDefinitionKeys.lists(), (oldData: DestinationDefinitions | undefined) => {
          const newMap = new Map(oldData?.destinationDefinitionMap);
          newMap.delete(body.destinationDefinitionId);
          return {
            destinationDefinitions:
              oldData?.destinationDefinitions.filter(
                ({ destinationDefinitionId }) => destinationDefinitionId !== body.destinationDefinitionId
              ) ?? [],
            destinationDefinitionMap: newMap,
          };
        });
        queryClient.invalidateQueries(connectorDefinitionKeys.count());
      },
    }
  );

  return {
    deleteDestinationDefinition: mutateAsync,
  };
};

/**
 * used in the embedded onboarding flow to get the list of destination definitions... we almost never
 * want this list, as it is not scoped to the current workspace and will return all destination definitions
 *
 * however, in this case, we do want it because we don't have a workspace id to use.
 *
 * this will be replaced by a sonar-specific endpoint in the future
 *
 */
export const useGlobalDestinationDefinitionList = () => {
  const requestOptions = useRequestOptions();

  return useQuery(
    destinationDefinitionKeys.lists(),
    async () => {
      const { destinationDefinitions } = await listDestinationDefinitions(requestOptions).then(
        ({ destinationDefinitions }) => ({
          destinationDefinitions: destinationDefinitions.sort((a, b) => a.name.localeCompare(b.name)),
        })
      );
      const destinationDefinitionMap = new Map<string, DestinationDefinitionRead>();
      destinationDefinitions.forEach((destinationDefinition) => {
        destinationDefinitionMap.set(destinationDefinition.destinationDefinitionId, destinationDefinition);
      });
      return {
        destinationDefinitions,
        destinationDefinitionMap,
      };
    },
    { suspense: true }
  ).data as DestinationDefinitions;
};
