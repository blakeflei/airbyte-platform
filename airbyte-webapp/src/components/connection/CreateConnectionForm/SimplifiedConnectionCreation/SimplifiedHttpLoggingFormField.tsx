import React from "react";
import { useController, useFormContext } from "react-hook-form";
import { FormattedMessage } from "react-intl";

import { CheckBox } from "components/ui/CheckBox";
import { FlexContainer } from "components/ui/Flex";
import { Message } from "components/ui/Message";
import { Text } from "components/ui/Text";

import { FormConnectionFormValues } from "../../ConnectionForm/formConfig";

interface SimplifiedHttpLoggingFormFieldProps {
  disabled?: boolean;
}

/**
 * Form field component for enabling detailed HTTP/HTTPS request logging.
 * This feature logs ALL sensitive information including API URLs, headers, 
 * query parameters, request/response bodies, and authentication details.
 * Only recommended for secure development environments.
 */
export const SimplifiedHttpLoggingFormField: React.FC<SimplifiedHttpLoggingFormFieldProps> = ({ disabled }) => {
  const { control } = useFormContext<FormConnectionFormValues>();
  
  const {
    field: { value, onChange },
  } = useController({
    name: "logAllHttpCalls",
    control,
    defaultValue: false,
  });

  return (
    <FlexContainer direction="column" gap="sm">
      <CheckBox
        id="logAllHttpCalls"
        name="logAllHttpCalls"
        checked={value}
        onChange={(event) => onChange(event.target.checked)}
        disabled={disabled}
        label={<FormattedMessage id="connectionForm.logAllHttpCalls.label" />}
        data-testid="log-all-http-calls-checkbox"
      />
      
      <Text size="sm" color="grey">
        <FormattedMessage id="connectionForm.logAllHttpCalls.description" />
      </Text>

      {value && (
        <Message type="warning" text={<FormattedMessage id="connectionForm.logAllHttpCalls.warning" />} />
      )}
    </FlexContainer>
  );
};