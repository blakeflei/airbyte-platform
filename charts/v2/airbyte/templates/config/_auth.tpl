
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Auth Configuration
*/}}

{{/*
Renders the global.auth.instanceAdmin.password value
*/}}
{{- define "airbyte.auth.instanceAdmin.password" }}
    {{- .Values.global.auth.instanceAdmin.password }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.password secret key
*/}}
{{- define "airbyte.auth.instanceAdmin.password.secretKey" }}
	{{- .Values.global.auth.instanceAdmin.passwordSecretKey | default "instance-admin-password" }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.password environment variable
*/}}
{{- define "airbyte.auth.instanceAdmin.password.env" }}
- name: AB_INSTANCE_ADMIN_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.managedSecretName" . }}
      key: {{ include "airbyte.auth.instanceAdmin.password.secretKey" . }}
{{- end }}

{{/*
Renders the set of all auth environment variables
*/}}
{{- define "airbyte.auth.envs" }}
{{- include "airbyte.auth.instanceAdmin.password.env" . }}
{{- end }}

{{/*
Renders the auth.bootstrap secret name
*/}}
{{- define "airbyte.auth.bootstrap.secretName" }}
{{- if .Values.global.auth.secretName }}
    {{- .Values.global.auth.secretName }}
{{- else }}
    {{- .Values.global.secretName | default (printf "%s-airbyte-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the global.auth.secretCreationEnabled value
*/}}
{{- define "airbyte.auth.bootstrap.secretCreationEnabled" }}
	{{- if eq .Values.global.auth.secretCreationEnabled nil }}
    	{{- true }}
	{{- else }}
    	{{- .Values.global.auth.secretCreationEnabled }}
	{{- end }}
{{- end }}

{{/*
Renders the auth.bootstrap.secretCreationEnabled environment variable
*/}}
{{- define "airbyte.auth.bootstrap.secretCreationEnabled.env" }}
- name: AB_AUTH_SECRET_CREATION_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AUTH_SECRET_CREATION_ENABLED
{{- end }}

{{/*
Renders the global.auth.managedSecretName value
*/}}
{{- define "airbyte.auth.bootstrap.managedSecretName" }}
    {{- .Values.global.auth.managedSecretName | default "airbyte-auth-secrets" }}
{{- end }}

{{/*
Renders the auth.bootstrap.managedSecretName environment variable
*/}}
{{- define "airbyte.auth.bootstrap.managedSecretName.env" }}
- name: AB_KUBERNETES_SECRET_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_KUBERNETES_SECRET_NAME
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.password value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.password" }}
    {{- .Values.global.auth.instanceAdmin.password }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.password secret key
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.password.secretKey" }}
	{{- .Values.global.auth.instanceAdmin.passwordSecretKey | default "AB_INSTANCE_ADMIN_PASSWORD" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.password environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.password.env" }}
- name: AB_INSTANCE_ADMIN_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.secretName" . }}
      key: {{ include "airbyte.auth.bootstrap.instanceAdmin.password.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.passwordSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.passwordSecretKey" }}
    {{- .Values.global.auth.instanceAdmin.passwordSecretKey | default "instance-admin-password" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.passwordSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.passwordSecretKey.env" }}
- name: AB_INSTANCE_ADMIN_PASSWORD_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_INSTANCE_ADMIN_PASSWORD_SECRET_KEY
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.clientId value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientId" }}
    {{- .Values.global.auth.instanceAdmin.clientId }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientId secret key
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientId.secretKey" }}
	{{- .Values.global.auth.instanceAdmin.clientIdSecretKey | default "AB_INSTANCE_ADMIN_CLIENT_ID" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientId environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientId.env" }}
- name: AB_INSTANCE_ADMIN_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.secretName" . }}
      key: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientId.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.clientIdSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientIdSecretKey" }}
    {{- .Values.global.auth.instanceAdmin.clientIdSecretKey | default "instance-admin-client-id" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientIdSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientIdSecretKey.env" }}
- name: AB_INSTANCE_ADMIN_CLIENT_ID_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_INSTANCE_ADMIN_CLIENT_ID_SECRET_KEY
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.clientSecret value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientSecret" }}
    {{- .Values.global.auth.instanceAdmin.clientSecret }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientSecret secret key
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientSecret.secretKey" }}
	{{- .Values.global.auth.instanceAdmin.clientSecretSecretKey | default "AB_INSTANCE_ADMIN_CLIENT_SECRET" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientSecret environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientSecret.env" }}
- name: AB_INSTANCE_ADMIN_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.secretName" . }}
      key: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientSecret.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.clientSecretSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientSecretSecretKey" }}
    {{- .Values.global.auth.instanceAdmin.clientSecretSecretKey | default "instance-admin-client-secret" }}
{{- end }}

{{/*
Renders the auth.bootstrap.instanceAdmin.clientSecretSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.instanceAdmin.clientSecretSecretKey.env" }}
- name: AB_INSTANCE_ADMIN_CLIENT_SECRET_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_INSTANCE_ADMIN_CLIENT_SECRET_SECRET_KEY
{{- end }}

{{/*
Renders the global.auth.security.jwtSignatureSecret value
*/}}
{{- define "airbyte.auth.bootstrap.security.jwtSignatureSecret" }}
    {{- .Values.global.auth.security.jwtSignatureSecret }}
{{- end }}

{{/*
Renders the auth.bootstrap.security.jwtSignatureSecret secret key
*/}}
{{- define "airbyte.auth.bootstrap.security.jwtSignatureSecret.secretKey" }}
	{{- .Values.global.auth.security.jwtSignatureSecretSecretKey | default "AB_JWT_SIGNATURE_SECRET" }}
{{- end }}

{{/*
Renders the auth.bootstrap.security.jwtSignatureSecret environment variable
*/}}
{{- define "airbyte.auth.bootstrap.security.jwtSignatureSecret.env" }}
- name: AB_JWT_SIGNATURE_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.secretName" . }}
      key: {{ include "airbyte.auth.bootstrap.security.jwtSignatureSecret.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.security.jwtSignatureSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.security.jwtSignatureSecretKey" }}
    {{- .Values.global.auth.security.jwtSignatureSecretKey | default "jwt-signature-secret" }}
{{- end }}

{{/*
Renders the auth.bootstrap.security.jwtSignatureSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.security.jwtSignatureSecretKey.env" }}
- name: AB_JWT_SIGNATURE_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_JWT_SIGNATURE_SECRET_KEY
{{- end }}

{{/*
Renders the global.auth.dataPlane.clientIdSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.dataPlane.clientIdSecretKey" }}
    {{- .Values.global.auth.dataPlane.clientIdSecretKey | default "dataplane-client-id" }}
{{- end }}

{{/*
Renders the auth.bootstrap.dataPlane.clientIdSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.dataPlane.clientIdSecretKey.env" }}
- name: DATAPLANE_CLIENT_ID_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATAPLANE_CLIENT_ID_SECRET_KEY
{{- end }}

{{/*
Renders the global.auth.dataPlane.clientSecretSecretKey value
*/}}
{{- define "airbyte.auth.bootstrap.dataPlane.clientSecretSecretKey" }}
    {{- .Values.global.auth.dataPlane.clientSecretSecretKey | default "dataplane-client-secret" }}
{{- end }}

{{/*
Renders the auth.bootstrap.dataPlane.clientSecretSecretKey environment variable
*/}}
{{- define "airbyte.auth.bootstrap.dataPlane.clientSecretSecretKey.env" }}
- name: DATAPLANE_CLIENT_SECRET_SECRET_KEY
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DATAPLANE_CLIENT_SECRET_SECRET_KEY
{{- end }}

{{/*
Renders the set of all auth.bootstrap environment variables
*/}}
{{- define "airbyte.auth.bootstrap.envs" }}
{{- include "airbyte.auth.bootstrap.secretCreationEnabled.env" . }}
{{- include "airbyte.auth.bootstrap.managedSecretName.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.password.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.passwordSecretKey.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.clientId.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.clientIdSecretKey.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.clientSecret.env" . }}
{{- include "airbyte.auth.bootstrap.instanceAdmin.clientSecretSecretKey.env" . }}
{{- include "airbyte.auth.bootstrap.security.jwtSignatureSecret.env" . }}
{{- include "airbyte.auth.bootstrap.security.jwtSignatureSecretKey.env" . }}
{{- include "airbyte.auth.bootstrap.dataPlane.clientIdSecretKey.env" . }}
{{- include "airbyte.auth.bootstrap.dataPlane.clientSecretSecretKey.env" . }}
{{- end }}

{{/*
Renders the set of all auth.bootstrap config map variables
*/}}
{{- define "airbyte.auth.bootstrap.configVars" }}
AB_AUTH_SECRET_CREATION_ENABLED: {{ include "airbyte.auth.bootstrap.secretCreationEnabled" . | quote }}
AB_KUBERNETES_SECRET_NAME: {{ include "airbyte.auth.bootstrap.managedSecretName" . | quote }}
AB_INSTANCE_ADMIN_PASSWORD_SECRET_KEY: {{ include "airbyte.auth.bootstrap.instanceAdmin.passwordSecretKey" . | quote }}
AB_INSTANCE_ADMIN_CLIENT_ID_SECRET_KEY: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientIdSecretKey" . | quote }}
AB_INSTANCE_ADMIN_CLIENT_SECRET_SECRET_KEY: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientSecretSecretKey" . | quote }}
AB_JWT_SIGNATURE_SECRET_KEY: {{ include "airbyte.auth.bootstrap.security.jwtSignatureSecretKey" . | quote }}
DATAPLANE_CLIENT_ID_SECRET_KEY: {{ include "airbyte.auth.bootstrap.dataPlane.clientIdSecretKey" . | quote }}
DATAPLANE_CLIENT_SECRET_SECRET_KEY: {{ include "airbyte.auth.bootstrap.dataPlane.clientSecretSecretKey" . | quote }}
{{- end }}

{{/*
Renders the set of all auth.bootstrap secret variables
*/}}
{{- define "airbyte.auth.bootstrap.secrets" }}
AB_INSTANCE_ADMIN_PASSWORD: {{ include "airbyte.auth.bootstrap.instanceAdmin.password" . | quote }}
AB_INSTANCE_ADMIN_CLIENT_ID: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientId" . | quote }}
AB_INSTANCE_ADMIN_CLIENT_SECRET: {{ include "airbyte.auth.bootstrap.instanceAdmin.clientSecret" . | quote }}
AB_JWT_SIGNATURE_SECRET: {{ include "airbyte.auth.bootstrap.security.jwtSignatureSecret" . | quote }}
{{- end }}

{{/*
Renders the auth.identityProvider secret name
*/}}
{{- define "airbyte.auth.identityProvider.secretName" }}
{{- if .Values.global.auth.identityProvider.secretName }}
    {{- .Values.global.auth.identityProvider.secretName }}
{{- else }}
    {{- .Values.global.secretName | default (printf "%s-airbyte-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the global.auth.identityProvider.type value
*/}}
{{- define "airbyte.auth.identityProvider.type" }}
    {{- .Values.global.auth.identityProvider.type | default "simple" }}
{{- end }}

{{/*
Renders the auth.identityProvider.type environment variable
*/}}
{{- define "airbyte.auth.identityProvider.type.env" }}
- name: IDENTITY_PROVIDER_TYPE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: IDENTITY_PROVIDER_TYPE
{{- end }}

{{/*
Renders the global.auth.identityProvider.verifyIssuer value
*/}}
{{- define "airbyte.auth.identityProvider.verifyIssuer" }}
	{{- if eq .Values.global.auth.identityProvider.verifyIssuer nil }}
    	{{- false }}
	{{- else }}
    	{{- .Values.global.auth.identityProvider.verifyIssuer }}
	{{- end }}
{{- end }}

{{/*
Renders the auth.identityProvider.verifyIssuer environment variable
*/}}
{{- define "airbyte.auth.identityProvider.verifyIssuer.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_ISSUER
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_ISSUER
{{- end }}

{{/*
Renders the global.auth.identityProvider.verifyAudience value
*/}}
{{- define "airbyte.auth.identityProvider.verifyAudience" }}
	{{- if eq .Values.global.auth.identityProvider.verifyAudience nil }}
    	{{- false }}
	{{- else }}
    	{{- .Values.global.auth.identityProvider.verifyAudience }}
	{{- end }}
{{- end }}

{{/*
Renders the auth.identityProvider.verifyAudience environment variable
*/}}
{{- define "airbyte.auth.identityProvider.verifyAudience.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_AUDIENCE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_AUDIENCE
{{- end }}

{{/*
Renders the global.auth.identityProvider.oidc.domain value
*/}}
{{- define "airbyte.auth.identityProvider.oidc.domain" }}
    {{- .Values.global.auth.identityProvider.oidc.domain }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.domain environment variable
*/}}
{{- define "airbyte.auth.identityProvider.oidc.domain.env" }}
- name: OIDC_DOMAIN
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: OIDC_DOMAIN
{{- end }}

{{/*
Renders the global.auth.identityProvider.oidc.appName value
*/}}
{{- define "airbyte.auth.identityProvider.oidc.appName" }}
    {{- .Values.global.auth.identityProvider.oidc.appName }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.appName environment variable
*/}}
{{- define "airbyte.auth.identityProvider.oidc.appName.env" }}
- name: OIDC_APP_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: OIDC_APP_NAME
{{- end }}

{{/*
Renders the global.auth.identityProvider.oidc.clientId value
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientId" }}
    {{- .Values.global.auth.identityProvider.oidc.clientId }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.clientId secret key
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientId.secretKey" }}
	{{- .Values.global.auth.identityProvider.oidc.clientIdSecretKey | default "OIDC_CLIENT_ID" }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.clientId environment variable
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientId.env" }}
- name: OIDC_CLIENT_ID
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.identityProvider.secretName" . }}
      key: {{ include "airbyte.auth.identityProvider.oidc.clientId.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.identityProvider.oidc.clientSecret value
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientSecret" }}
    {{- .Values.global.auth.identityProvider.oidc.clientSecret }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.clientSecret secret key
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientSecret.secretKey" }}
	{{- .Values.global.auth.identityProvider.oidc.clientSecretSecretKey | default "OIDC_CLIENT_SECRET" }}
{{- end }}

{{/*
Renders the auth.identityProvider.oidc.clientSecret environment variable
*/}}
{{- define "airbyte.auth.identityProvider.oidc.clientSecret.env" }}
- name: OIDC_CLIENT_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.identityProvider.secretName" . }}
      key: {{ include "airbyte.auth.identityProvider.oidc.clientSecret.secretKey" . }}
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.clientId value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.clientId" }}
    {{- .Values.global.auth.identityProvider.genericOidc.clientId }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.clientId environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.clientId.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_CLIENT_ID
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_CLIENT_ID
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.audience value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.audience" }}
    {{- .Values.global.auth.identityProvider.genericOidc.audience }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.audience environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.audience.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_AUDIENCE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_AUDIENCE
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.issuer value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.issuer" }}
    {{- .Values.global.auth.identityProvider.genericOidc.issuer }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.issuer environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.issuer.env" }}
- name: DEFAULT_REALM
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: DEFAULT_REALM
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint" }}
    {{- .Values.global.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_ENDPOINTS_AUTHORIZATION_SERVER_ENDPOINT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_ENDPOINTS_AUTHORIZATION_SERVER_ENDPOINT
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.endpoints.jwksEndpoint value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.endpoints.jwksEndpoint" }}
    {{- .Values.global.auth.identityProvider.genericOidc.endpoints.jwksEndpoint }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.endpoints.jwksEndpoint environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.endpoints.jwksEndpoint.env" }}
- name: AB_AIRBYTE_AUTH_JWKS_ENDPOINT
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_JWKS_ENDPOINT
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.fields.subject value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.subject" }}
    {{- .Values.global.auth.identityProvider.genericOidc.fields.subject | default "sub" }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.fields.subject environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.subject.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_SUB
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_SUB
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.fields.email value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.email" }}
    {{- .Values.global.auth.identityProvider.genericOidc.fields.email | default "email" }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.fields.email environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.email.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_EMAIL
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_EMAIL
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.fields.name value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.name" }}
    {{- .Values.global.auth.identityProvider.genericOidc.fields.name | default "name" }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.fields.name environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.name.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_NAME
{{- end }}

{{/*
Renders the global.auth.identityProvider.genericOidc.fields.issuer value
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.issuer" }}
    {{- .Values.global.auth.identityProvider.genericOidc.fields.issuer | default "iss" }}
{{- end }}

{{/*
Renders the auth.identityProvider.genericOidc.fields.issuer environment variable
*/}}
{{- define "airbyte.auth.identityProvider.genericOidc.fields.issuer.env" }}
- name: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_ISSUER
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_ISSUER
{{- end }}

{{/*
Renders the set of all auth.identityProvider environment variables
*/}}
{{- define "airbyte.auth.identityProvider.envs" }}
{{- include "airbyte.auth.identityProvider.type.env" . }}
{{- include "airbyte.auth.identityProvider.verifyIssuer.env" . }}
{{- include "airbyte.auth.identityProvider.verifyAudience.env" . }}
{{- $opt := (include "airbyte.auth.identityProvider.type" .) }}

{{- if eq $opt "oidc" }}
{{- include "airbyte.auth.identityProvider.oidc.domain.env" . }}
{{- include "airbyte.auth.identityProvider.oidc.appName.env" . }}
{{- include "airbyte.auth.identityProvider.oidc.clientId.env" . }}
{{- include "airbyte.auth.identityProvider.oidc.clientSecret.env" . }}
{{- end }}

{{- if eq $opt "generic-oidc" }}
{{- include "airbyte.auth.identityProvider.genericOidc.clientId.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.audience.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.issuer.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.endpoints.jwksEndpoint.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.fields.subject.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.fields.email.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.fields.name.env" . }}
{{- include "airbyte.auth.identityProvider.genericOidc.fields.issuer.env" . }}
{{- end }}

{{- end }}

{{/*
Renders the set of all auth.identityProvider config map variables
*/}}
{{- define "airbyte.auth.identityProvider.configVars" }}
IDENTITY_PROVIDER_TYPE: {{ include "airbyte.auth.identityProvider.type" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_ISSUER: {{ include "airbyte.auth.identityProvider.verifyIssuer" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_VERIFY_AUDIENCE: {{ include "airbyte.auth.identityProvider.verifyAudience" . | quote }}
{{- $opt := (include "airbyte.auth.identityProvider.type" .) }}

{{- if eq $opt "oidc" }}
OIDC_DOMAIN: {{ include "airbyte.auth.identityProvider.oidc.domain" . | quote }}
OIDC_APP_NAME: {{ include "airbyte.auth.identityProvider.oidc.appName" . | quote }}
{{- end }}

{{- if eq $opt "generic-oidc" }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_CLIENT_ID: {{ include "airbyte.auth.identityProvider.genericOidc.clientId" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_AUDIENCE: {{ include "airbyte.auth.identityProvider.genericOidc.audience" . | quote }}
DEFAULT_REALM: {{ include "airbyte.auth.identityProvider.genericOidc.issuer" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_ENDPOINTS_AUTHORIZATION_SERVER_ENDPOINT: {{ include "airbyte.auth.identityProvider.genericOidc.endpoints.authorizationServerEndpoint" . | quote }}
AB_AIRBYTE_AUTH_JWKS_ENDPOINT: {{ include "airbyte.auth.identityProvider.genericOidc.endpoints.jwksEndpoint" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_SUB: {{ include "airbyte.auth.identityProvider.genericOidc.fields.subject" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_EMAIL: {{ include "airbyte.auth.identityProvider.genericOidc.fields.email" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_NAME: {{ include "airbyte.auth.identityProvider.genericOidc.fields.name" . | quote }}
AB_AIRBYTE_AUTH_IDENTITY_PROVIDER_OIDC_FIELDS_ISSUER: {{ include "airbyte.auth.identityProvider.genericOidc.fields.issuer" . | quote }}
{{- end }}

{{- end }}

{{/*
Renders the set of all auth.identityProvider secret variables
*/}}
{{- define "airbyte.auth.identityProvider.secrets" }}
{{- $opt := (include "airbyte.auth.identityProvider.type" .) }}

{{- if eq $opt "oidc" }}
OIDC_CLIENT_ID: {{ include "airbyte.auth.identityProvider.oidc.clientId" . | quote }}
OIDC_CLIENT_SECRET: {{ include "airbyte.auth.identityProvider.oidc.clientSecret" . | quote }}
{{- end }}

{{- if eq $opt "generic-oidc" }}
{{- end }}

{{- end }}

{{/*
Renders the auth.instanceAdmin.enterprise secret name
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.secretName" }}
{{- if .Values.global.auth.instanceAdmin.secretName }}
    {{- .Values.global.auth.instanceAdmin.secretName }}
{{- else }}
    {{- .Values.global.secretName | default (printf "%s-airbyte-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.firstName value
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.firstName" }}
    {{- .Values.global.auth.instanceAdmin.firstName }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.enterprise.firstName environment variable
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.firstName.env" }}
- name: INITIAL_USER_FIRST_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: INITIAL_USER_FIRST_NAME
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.lastName value
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.lastName" }}
    {{- .Values.global.auth.instanceAdmin.lastName }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.enterprise.lastName environment variable
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.lastName.env" }}
- name: INITIAL_USER_LAST_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: INITIAL_USER_LAST_NAME
{{- end }}

{{/*
Renders the global.auth.instanceAdmin.password value
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.password" }}
    {{- .Values.global.auth.instanceAdmin.password }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.enterprise.password secret key
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.password.secretKey" }}
	{{- .Values.global.auth.instanceAdmin.passwordSecretKey | default "INITIAL_USER_PASSWORD" }}
{{- end }}

{{/*
Renders the auth.instanceAdmin.enterprise.password environment variable
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.password.env" }}
- name: INITIAL_USER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.instanceAdmin.enterprise.secretName" . }}
      key: {{ include "airbyte.auth.instanceAdmin.enterprise.password.secretKey" . }}
{{- end }}

{{/*
Renders the set of all auth.instanceAdmin.enterprise environment variables
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.envs" }}
{{- include "airbyte.auth.instanceAdmin.enterprise.firstName.env" . }}
{{- include "airbyte.auth.instanceAdmin.enterprise.lastName.env" . }}
{{- include "airbyte.auth.instanceAdmin.enterprise.password.env" . }}
{{- end }}

{{/*
Renders the set of all auth.instanceAdmin.enterprise config map variables
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.configVars" }}
INITIAL_USER_FIRST_NAME: {{ include "airbyte.auth.instanceAdmin.enterprise.firstName" . | quote }}
INITIAL_USER_LAST_NAME: {{ include "airbyte.auth.instanceAdmin.enterprise.lastName" . | quote }}
{{- end }}

{{/*
Renders the set of all auth.instanceAdmin.enterprise secret variables
*/}}
{{- define "airbyte.auth.instanceAdmin.enterprise.secrets" }}
INITIAL_USER_PASSWORD: {{ include "airbyte.auth.instanceAdmin.enterprise.password" . | quote }}
{{- end }}

{{/*
Renders the auth.jwt secret name
*/}}
{{- define "airbyte.auth.jwt.secretName" }}
{{- if .Values.global.auth.instanceAdmin.secretName }}
    {{- .Values.global.auth.instanceAdmin.secretName }}
{{- else }}
    {{- .Values.global.secretName | default (printf "%s-airbyte-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the global.auth.security.jwtSignatureSecret value
*/}}
{{- define "airbyte.auth.jwt.jwtSignatureSecret" }}
    {{- .Values.global.auth.security.jwtSignatureSecret }}
{{- end }}

{{/*
Renders the auth.jwt.jwtSignatureSecret secret key
*/}}
{{- define "airbyte.auth.jwt.jwtSignatureSecret.secretKey" }}
	{{- .Values.global.auth.security.jwtSignatureSecretSecretKey | default "jwt-signature-secret" }}
{{- end }}

{{/*
Renders the auth.jwt.jwtSignatureSecret environment variable
*/}}
{{- define "airbyte.auth.jwt.jwtSignatureSecret.env" }}
- name: AB_JWT_SIGNATURE_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte.auth.bootstrap.managedSecretName" . }}
      key: {{ include "airbyte.auth.jwt.jwtSignatureSecret.secretKey" . }}
{{- end }}

{{/*
Renders the set of all auth.jwt environment variables
*/}}
{{- define "airbyte.auth.jwt.envs" }}
{{- include "airbyte.auth.jwt.jwtSignatureSecret.env" . }}
{{- end }}

{{/*
Renders the global.auth.security.cookieSecureSetting value
*/}}
{{- define "airbyte.auth.security.cookieSecureSetting" }}
	{{- if eq .Values.global.auth.security.cookieSecureSetting nil }}
    	{{- true }}
	{{- else }}
    	{{- .Values.global.auth.security.cookieSecureSetting }}
	{{- end }}
{{- end }}

{{/*
Renders the auth.security.cookieSecureSetting environment variable
*/}}
{{- define "airbyte.auth.security.cookieSecureSetting.env" }}
- name: AB_COOKIE_SECURE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_COOKIE_SECURE
{{- end }}

{{/*
Renders the global.auth.security.cookieSameSiteSetting value
*/}}
{{- define "airbyte.auth.security.cookieSameSiteSetting" }}
    {{- .Values.global.auth.security.cookieSameSiteSetting | default "strict" }}
{{- end }}

{{/*
Renders the auth.security.cookieSameSiteSetting environment variable
*/}}
{{- define "airbyte.auth.security.cookieSameSiteSetting.env" }}
- name: AB_COOKIE_SAME_SITE
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-env
      key: AB_COOKIE_SAME_SITE
{{- end }}

{{/*
Renders the set of all auth.security environment variables
*/}}
{{- define "airbyte.auth.security.envs" }}
{{- include "airbyte.auth.security.cookieSecureSetting.env" . }}
{{- include "airbyte.auth.security.cookieSameSiteSetting.env" . }}
{{- end }}

{{/*
Renders the set of all auth.security config map variables
*/}}
{{- define "airbyte.auth.security.configVars" }}
AB_COOKIE_SECURE: {{ include "airbyte.auth.security.cookieSecureSetting" . | quote }}
AB_COOKIE_SAME_SITE: {{ include "airbyte.auth.security.cookieSameSiteSetting" . | quote }}
{{- end }}
