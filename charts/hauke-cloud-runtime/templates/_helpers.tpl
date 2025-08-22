{{/*
Expand the name of the chart.
*/}}
{{- define "hauke-cloud-runtime.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hauke-cloud-runtime.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hauke-cloud-runtime.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hauke-cloud-runtime.labels" -}}
helm.sh/chart: {{ include "hauke-cloud-runtime.chart" . }}
{{ include "hauke-cloud-runtime.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hauke-cloud-runtime.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hauke-cloud-runtime.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hauke-cloud-runtime.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hauke-cloud-runtime.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "general.targetCluster" }}
  {{- .Values.general.targetCluster | required "A value for general.targetCluster is required" }}
{{- end }}

{{- define "general.project" }}
  {{- .Values.general.project | required "A Value for general.project is required" }}
{{- end }}

{{- define "application.name" }}
  {{- .name | required "a name is required for the application to be deployed"}}
{{- end }}

{{- define "application.namespace" }}
  {{- .namespace | required "a namespace is required for the application to be deployed"}}
{{- end }}

{{- define "application.source" }}
  {{- $releaseName := dict "releaseName" (include "application.name" . ) }}
  {{- if .source.chart }}
    {{- if .source.helm }}
        {{- $helmsource := dict "helm" (merge $releaseName .source.helm) }}
        {{- $source := merge $helmsource .source }}
        {{- toYaml $source }}
    {{- else }}
        {{- $helmsource := dict "helm" $releaseName  }}
        {{- $source := merge $helmsource .source }}
        {{- toYaml $source }}
    {{- end }}
  {{- else }}
    {{- toYaml .source }}
  {{- end }}
{{- end }}
