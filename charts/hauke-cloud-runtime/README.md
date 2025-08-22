# hauke-cloud-runtime

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Umbrella chart which provides all basic Kubernetes cluster services

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certManager.enabled | bool | `true` |  |
| certManager.name | string | `"cert-manager"` |  |
| certManager.namespace | string | `"cert-manager"` |  |
| certManager.source.chart | string | `"cert-manager"` |  |
| certManager.source.helm.values | string | `"resources:\n  requests:\n    cpu: 50m\n    memory: 64Mi\n  limits:\n    memory: 96Mi\ncainjector:\n  resources:\n    requests:\n      cpu: 50m\n      memory: 96Mi\n    limits:\n      memory: 96Mi\nwebhook:\n  resources:\n    requests:\n      cpu: 50m\n      memory: 96Mi\n    limits:\n      memory: 96Mi\nstartupapicheck:\n  resources:\n    requests:\n      cpu: 50m\n      memory: 96Mi\n    limits:\n      memory: 96Mi\ncrds:\n  enabled: true\n"` |  |
| certManager.source.repoURL | string | `"https://charts.jetstack.io"` |  |
| certManager.source.targetRevision | string | `"1.18.2"` |  |
| externalSecrets.enabled | bool | `true` |  |
| externalSecrets.name | string | `"external-secrets"` |  |
| externalSecrets.namespace | string | `"external-secrets"` |  |
| externalSecrets.source.chart | string | `"external-secrets"` |  |
| externalSecrets.source.helm.values | string | `"resources:\n  requests:\n    cpu: 250m\n    memory: 384Mi\n  limits:\n    memory: 512Mi\nwebhook:\n  resources:\n    requests:\n      cpu: 50m\n      memory: 96Mi\n    limits:\n      memory: 128Mi\ncertController:\n  resources:\n    requests:\n      cpu: 50m\n      memory: 96Mi\n    limits:\n      memory: 96Mi\n"` |  |
| externalSecrets.source.repoURL | string | `"https://charts.external-secrets.io"` |  |
| externalSecrets.source.targetRevision | string | `"0.16.2"` |  |
| fullnameOverride | string | `""` |  |
| general.project | string | `"default"` |  |
| general.targetCluster | string | `"in-cluster"` |  |
| nameOverride | string | `""` |  |
| smbDriver.enabled | bool | `true` |  |
| smbDriver.name | string | `"smb-driver"` |  |
| smbDriver.namespace | string | `"kube-system"` |  |
| smbDriver.source.chart | string | `"csi-driver-smb"` |  |
| smbDriver.source.helm.values | string | `"windows:\n  enabled: false\n"` |  |
| smbDriver.source.repoURL | string | `"https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/charts"` |  |
| smbDriver.source.targetRevision | string | `"1.9.0"` |  |
| traefik.enabled | bool | `true` |  |
| traefik.name | string | `"traefik"` |  |
| traefik.namespace | string | `"ingress"` |  |
| traefik.source.chart | string | `"traefik"` |  |
| traefik.source.helm.values | string | `"resources:\n  requests:\n    cpu: 500m\n    memory: 1Gi\n  limits:\n    memory: 1.5Gi\ndeployment:\n  enabled: true\n  kind: DaemonSet\n  dnsPolicy: ClusterFirst\nservice:\n  spec:\n    externalTrafficPolicy: Local\nglobalArguments:\n  - \"--providers.kubernetescrd\"\n  - \"--providers.kubernetesingress\"\n  - \"--api.insecure=true\"\n  - \"--accesslog\"\n  - \"--providers.kubernetesIngress.ingressEndpoint.publishedService=ingress/traefik\"\n"` |  |
| traefik.source.repoURL | string | `"https://traefik.github.io/charts"` |  |
| traefik.source.targetRevision | string | `"36.3.0"` |  |
| trustManager.enabled | bool | `true` |  |
| trustManager.name | string | `"trust-manager"` |  |
| trustManager.namespace | string | `"cert-manager"` |  |
| trustManager.source.chart | string | `"trust-manager"` |  |
| trustManager.source.helm.values | string | `"defaultPackage:\n  resources:\n    requests:\n      cpu: 100m\n      memory: 64Mi\n    limits:\n      memory: 64Mi\nresources:\n  requests:\n    cpu: 50m\n    memory: 64Mi\n  limits:\n    memory: 64Mi\nsecretTargets:\n  enabled: true\n  authorizedSecretsAll: true\n  authorizedSecrets:\n    - ca-for.gigabit-grundbuch.private-secret\n"` |  |
| trustManager.source.repoURL | string | `"https://charts.jetstack.io"` |  |
| trustManager.source.targetRevision | string | `"0.18.0"` |  |
