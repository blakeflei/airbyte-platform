import fs from "node:fs";
import path from "node:path";

import traverse, { SchemaObject } from "json-schema-traverse";
import { defineConfig, Options } from "orval";

import * as apis from "./src/core/api/apis";

type ApiFn = keyof typeof apis;

// Unfortunately orval doesn't export any of those types, so we need to extract them from the actual exported Options type.
type InfoFn = NonNullable<Exclude<Options["output"], string | undefined>["override"]>["header"];

const JAVA_PROBLEM_BASE_CLASS = "io.airbyte.api.problems.ProblemResponse";
const BASE_FIELDS_SCHEMA = "BaseProblemFields";

const header: InfoFn = (info) => [
  `eslint-disable`,
  `Generated by orval 🍺`,
  `Do not edit manually. Run "pnpm run generate-client" instead.`,
  ...(info.title ? [info.title] : []),
  ...(info.description ? [info.description] : []),
  ...(info.version ? [`OpenAPI spec version: ${info.version}`] : []),
];

/**
 * A method returning a post processing hook that will generate the files that will reexport all types
 * into src/core/api/types.
 */
const createTypeReexportFile = (name: string) => {
  return () => {
    console.log(`Write type re-export file for ${name}...`);
    fs.writeFileSync(`./src/core/api/types/${name}.ts`, `export * from "../generated/${name}.schemas";\n`);
  };
};

/**
 * A post processing hook that will do all required transformation on the generated files.
 */
const postProcessFileContent = (files: string[]) => {
  console.log(`Post process generated content in ${path.basename(files[0])}...`);
  const newContent = fs
    .readFileSync(files[0], { encoding: "utf-8" })
    // Make the options parameter mandatory, so it can't be forgetten to be passed in
    .replace(/options\?: SecondParameter/g, "options: SecondParameter")
    // Turn optional parameters (e.g. GET with non required parameters) into a `| undefined` type instead
    // so they can be before the now mandatory options parameters.
    .replace(/\?: ([^,]+),((?:[\s\S][^)])*options: SecondParameter)/g, ": $1 | undefined,$2");
  fs.writeFileSync(files[0], newContent);
};

/**
 * Helper function to create an new auto generated API.
 *
 * @param inputSpecFile The path (relative to airbyte-webapp) to the OpenAPI spec from which to generate an API.
 * @param name The name of the output file for this API.
 * @param apiFn The API function in src/core/api/apis.ts to call for this API. This function must be specific
 *              for this API and use the base api path that this API is reachable under. You don't need to pass this
 *              for type only APIs (i.e. if you don't want to use the generated fetching functions).
 * @param excludedPaths A list of API pathes to filter out, i.e. code won't be generated for pathes in this array.
 */
const createApi = (inputSpecFile: string, name: string, apiFn?: ApiFn, excludedPaths?: string[]): Options => {
  return {
    input: {
      target: inputSpecFile,
      override: {
        transformer: (spec) => {
          if (!excludedPaths) {
            // If no API filter has been specified return the spec as it is.
            return spec;
          }

          return {
            ...spec,
            paths: Object.fromEntries(Object.entries(spec.paths).filter(([path]) => !excludedPaths.includes(path))),
          };
        },
      },
    },
    output: {
      mode: "split",
      target: `./src/core/api/generated/${name}.ts`,
      prettier: true,
      override: {
        header,
        // Do only use the mutator if an `apiFn` to call has been specified.
        ...(apiFn
          ? {
              mutator: {
                path: "./src/core/api/apis.ts",
                name: apiFn,
              },
            }
          : {}),
      },
    },
    hooks: {
      afterAllFilesWrite: [postProcessFileContent, createTypeReexportFile(name)],
    },
  };
};

const errorTypeGeneration = (inputSpec: string): Options => {
  return {
    input: {
      target: inputSpec,
      override: {
        transformer: (spec) => {
          if (Object.keys(spec.paths).length !== 0) {
            throw new Error("api-problems.yml should not have any actual paths (APIs) in its definition.");
          }
          if (!spec.components?.schemas) {
            throw new Error("api-problems.yml should have a components section with schemas.");
          }
          if (!spec.components.schemas[BASE_FIELDS_SCHEMA]) {
            throw new Error(`api-problems.yml should have a ${BASE_FIELDS_SCHEMA} schema.`);
          }
          if (spec.components.schemas.KnownApiProblem) {
            // Since we manually add this later we make sure there isn't a schema with the same type already defined.
            throw new Error(
              "api-problems.yml should not have a KnownApiProblem schema, or the webapp generation logic needs to be adjusted."
            );
          }
          if (spec.components.schemas.KnownApiProblemTypeAndPrefixes) {
            // Since we manually add this later we make sure there isn't a schema with the same type already defined.
            throw new Error(
              "api-problems.yml should not have a KnownApiProblemTypeAndPrefixes schema, or the webapp generation logic needs to be adjusted."
            );
          }

          // Transform each schema by some special logic needed for our type generation
          Object.entries(spec.components.schemas).forEach(([name, schema]) => {
            traverse(schema, {
              cb: (schema) => {
                // Turn some simple type with a default value into a const (single value enum) instead.
                // This is done to easy writing the spec when adding new variables and is not standard
                // OpenAPI behavior.
                if (
                  name !== BASE_FIELDS_SCHEMA &&
                  schema.default &&
                  (schema.type === "string" || schema.type === "integer")
                ) {
                  schema.enum = [schema.default];
                }
              },
            });
          });

          // Add one type that's am anyOf all other response types for having a proper union type in the webapp over all known types.
          spec.components.schemas.KnownApiProblem = {
            type: "object",
            anyOf: Object.entries(spec.components.schemas)
              .filter(([, schema]) => schema["x-implements"] === JAVA_PROBLEM_BASE_CLASS)
              .map(([name]) => ({ $ref: `#/components/schemas/${name}` })),
          };

          // Retrieve a list of all possible `type` keys of errors.
          const allTypes = Object.values(spec.components.schemas)
            .filter((schema) => schema["x-implements"] === JAVA_PROBLEM_BASE_CLASS)
            .map(
              (schema) =>
                // Since every type is an allOf with a ref to the base class and the actual fields we need to find the allOf entry that's not the
                // $ref and then read it's type.default value.
                !("$ref" in schema) &&
                schema.allOf?.find((s): s is SchemaObject => !("$ref" in s))?.properties?.type?.default
            )
            .filter(Boolean);

          // Now add all types to this object (for performance reasons not an array) and all possible prefixes of that object
          // e.g. add error:validation if we find error:validation/invalid-email.
          const allTypesWithPrefixes = {};
          for (const type of allTypes) {
            allTypesWithPrefixes[type] = true;
            if (type.startsWith("error:")) {
              const segments = type.split("/");
              for (let i = segments.length - 1; i > 0; i--) {
                allTypesWithPrefixes[segments.slice(0, i).join("/")] = true;
              }
            }
          }

          // Add a type to the spec that's a union of all the possible types and prefixes.
          spec.components.schemas.KnownApiProblemTypeAndPrefixes = {
            type: "string",
            enum: Object.keys(allTypesWithPrefixes),
          };

          return spec;
        },
      },
    },
    output: {
      target: "./src/core/api/errors/problems.ts",
      override: {
        header,
      },
    },
  };
};

// IMPORTANT: Whenever you change/add OpenAPI specs here, make sure to also adjust the outsideWebappDependencies list in build.gradle.kts
export default defineConfig({
  api: createApi("../airbyte-api/server-api/src/main/openapi/config.yaml", "AirbyteClient", "apiCall", [
    // Required to exclude, due to us not being able to convert JSON parameters
    "/public/v1/oauth/callback",
  ]),
  sonarApi: createApi(
    // todo: this should be an env variable probably, not a raw hardcoded url
    "https://airbyte-sonar-prod.s3.us-east-2.amazonaws.com/openapi/2025-07-14T17-26-30Z/51a5183c/app.json",
    "SonarClient",
    "sonarApiCall"
  ),
  connectorBuilder: createApi(
    "../airbyte-connector-builder-server/src/main/openapi/openapi.yaml",
    "ConnectorBuilderClient",
    "connectorBuilderApiCall"
  ),
  connectorManifest: createApi("./src/services/connectorBuilder/connector_manifest_openapi.yaml", "ConnectorManifest"),
  apiErrorTypes: errorTypeGeneration("../airbyte-api/problems-api/src/main/openapi/api-problems.yaml"),
});
