<!-- llm-readme-management spec=1 commit=1c40f945bbcf32328c618e8809cece0c2688c985 template=helm model=qwen3.6-35b-a3b digest=5b6cfbe96d9f generated=2026-09-08T19:47:56Z -->
<a href="https://hauke.cloud" target="_blank"><img src="https://img.shields.io/badge/home-hauke.cloud-brightgreen" alt="hauke.cloud" style="display: block;" /></a>
<a href="https://github.com/hauke-cloud" target="_blank"><img src="https://img.shields.io/badge/github-hauke.cloud-blue" alt="hauke.cloud Github Organisation" style="display: block;" /></a>
<a href="https://github.com/hauke-cloud/llm-readme-management" target="_blank"><img src="https://img.shields.io/badge/template-helm-orange" alt="Repository type - helm" style="display: block;" /></a>


# Hauke Cloud Runtime


<img src="https://raw.githubusercontent.com/hauke-cloud/.github/main/resources/img/organisation-logo-small.png" alt="hauke.cloud logo" width="109" height="123" align="right">


<llm header hint="Name the chart and what it deploys.">

This umbrella Helm chart generates Flux CD `HelmRelease` and `HelmRepository` custom resources to provision over fifteen upstream Kubernetes infrastructure components, including cert-manager, external-dns, and Cilium. The `hauke-cloud-runtime` chart is designed for platform operators managing self-hosted clusters who want to bootstrap cluster-level services through a single Git commit.

</llm>


## :book: Description

<llm description>

This repository provides an umbrella Helm chart that provisions a complete set of cluster-level infrastructure services on a Flux-managed Kubernetes cluster. Instead of managing dozens of individual upstream charts, you configure a single `values.yaml` file and commit it to Git. The chart translates your selections into Flux CD `HelmRepository` and `HelmRelease` custom resources, allowing Flux to automatically pull, version, and reconcile each component. As part of the `hauke-cloud` ecosystem, it is tailored for platform operators maintaining self-hosted clusters, including built-in configuration for Hetzner Cloud infrastructure components.

The chart manages the full lifecycle of included services through a unified configuration layer:
- Renders `HelmRepository` and `HelmRelease` CRDs for every enabled upstream chart
- Creates dedicated namespaces per component unless explicitly skipped
- Conditionally generates Gateway API resources when Envoy Gateway is active
- Enforces hardened CPU and memory resource limits across all included components

</llm>


## :clipboard: Requirements

<llm requirements hint="Give the Kubernetes version constraint from Chart.yaml, the Helm version, and any dependency charts or CRDs that must already be present.">

- A Kubernetes cluster with Flux CD installed and actively reconciling `HelmRelease` and `HelmRepository` custom resource definitions.
- The Helm 3.x CLI available in your environment for local rendering and packaging.
- Git and pre-commit installed locally to run the development toolchain and pre-commit hooks.
- A GitHub account with a personal access token or `GITHUB_TOKEN` scoped with `contents: write` and `packages: write` permissions, required by the CI pipeline to publish OCI chart artifacts.

</llm>


## 🚀 Getting started

<llm getting_started hint="helm repo add, helm install and helm upgrade with the real repository URL and chart name. Show a values override only if the chart needs one to start.">

</llm>


## :airplane: Usage

<llm usage hint="Show installing with a values file, and how to reach or verify the deployed workload.">

You configure the runtime by editing a values file to toggle components, pin upstream versions, and pass child-chart parameters. Once your configuration is ready, you install the chart using Helm 3. The command generates `HelmRepository` and `HelmRelease` custom resources that Flux CD will reconcile to deploy the actual workloads.

```bash
helm install runtime oci://ghcr.io/hauke-cloud/charts/hauke-cloud-runtime -f values.yaml
```

After installation, verify that the chart rendered the expected resources and that Flux has successfully reconciled them. You can inspect the generated namespaces and HelmRelease objects to confirm each component is active and running.

```bash
kubectl get helmrelease
kubectl get ns
```

</llm>


## :wrench: Configuration

<llm configuration hint="A table of the top-level values from values.yaml: key, default, description. Point at values.yaml for the full set.">

All configuration flows through `values.yaml`. You control which infrastructure components deploy by toggling their individual `<component>.enabled` flags and pinning upstream chart versions via `<component>.chart.version`. The chart also exposes standard Helm overrides like `nameOverride` and `fullnameOverride`, plus Envoy Gateway-specific options such as `envoyGateway.gatewayAPI.skipCapabilityCheck` to bypass Kubernetes version checks during offline rendering.

| Name | Type | Default | Required | Description |
|---|---|---|---|---|
| `nameOverride` | string | empty | no | Override chart name in rendered resources. |
| `fullnameOverride` | string | empty | no | Completely override the release fullname. |
| `<component>.enabled` | bool | varies (true for cert-manager, trust-manager, external-dns, ingress, metricsServer, descheduler, sealed-secrets; false for the rest) | yes | Master switch. |
| `<component>.chart.version` | string | component-specific (e.g. cert-manager 1.21.1) | yes | Exact version pin for the upstream chart. |
| `envoyGateway.gatewayAPI.skipCapabilityCheck` | bool | false | no | Force-skip Kubernetes version checks so templates render offline. |

You can pass arbitrary child-chart values through `<component>.values`, set per-component resource limits, or adjust repository URLs and types. The long tail of toggles for all fifteen included components is omitted here; consult `values.yaml` for the complete configuration surface.

</llm>


## 📄 License

This Project is licensed under the GNU General Public License v3.0

- see the [LICENSE](LICENSE) file for details.


## :coffee: Contributing

To become a contributor, please check out the [CONTRIBUTING](CONTRIBUTING.md) file.


## :email: Contact

For any inquiries or support requests, please open an issue in this
repository or contact us at [contact@hauke.cloud](mailto:contact@hauke.cloud).
