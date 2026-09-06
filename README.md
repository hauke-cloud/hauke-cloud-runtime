

<a href="https://hauke.cloud" target="_blank"><img src="https://img.shields.io/badge/home-hauke.cloud-brightgreen" alt="hauke.cloud" style="display: block;" /></a>
<a href="https://github.com/hauke-cloud" target="_blank"><img src="https://img.shields.io/badge/github-hauke.cloud-blue" alt="hauke.cloud Github Organisation" style="display: block;" /></a>
<a href="https://github.com/hauke-cloud/readme-management" target="_blank"><img src="https://img.shields.io/badge/template-helm-orange" alt="Repository type - helm" style="display: block;" /></a>


# hauke.cloud runtime


<img src="https://raw.githubusercontent.com/hauke-cloud/.github/main/resources/img/organisation-logo-small.png" alt="hauke.cloud logo" width="109" height="123" align="right">


Helm chart to various basic components like ingress controller, cert-manager, sealed-secrets, etc.

This chart offers you:
- All basic services for a basic Kubernetes cluster
- Regular updates for each component
- Hardening
- Zero-Trust approach





## 🚀 Getting started
To get started, you need to clone the repository. Follow the steps below:

### 1. Clone the repository

Use the following command to clone the repository:

```bash
git clone https://github.com/hauke-cloud/hauke-cloud-runtime.git
```

### 2. Navigate to the repository directory

Once the repository is cloned, navigate to the directory:

```bash
cd hauke-cloud-runtime
```

### 3. Check the content

```bash
ls -la
```

This will display all the files and directories in the cloned repository.



## :airplane: Usage
### Deploying the chart

Since we provide the chart in our public Github repository deploying it is
quite simple. You can run the following command to template and install the chart to your Kubernetes cluster:

#### Template the Helm chart

```bash
helm template oci://ghcr.io/hauke-cloud/charts/hauke-cloud-runtime
```

#### Deploy the Helm chart

```bash
helm install hauke-cloud-runtime oci://ghcr.io/hauke-cloud/charts/hauke-cloud-runtime --version 1.0.0
```



## :satellite: Envoy Gateway (Gateway API)

`envoyGateway` installs [Envoy Gateway](https://gateway.envoyproxy.io/) as the
Gateway API replacement for the `ingress` (ingress-nginx) component. Both can be
enabled at once, so an Ingress keeps serving traffic while its HTTPRoute is
added, and `ingress.enabled` is only set to `false` once every route has moved.

Enabling it does three things:

1. A `HelmRelease` installs `gateway-helm`, which brings the Envoy Gateway CRDs
   **and** the upstream Gateway API CRDs with it.
2. A `GatewayClass` (`envoyGateway.gatewayAPI.gatewayClass`) plus the
   `EnvoyProxy` it points at through `parametersRef`. The `EnvoyProxy` is where
   the data plane is configured -- its `envoyService` is the LoadBalancer that
   takes over from the ingress-nginx controller Service.
3. One `Gateway` per entry in `envoyGateway.gatewayAPI.gateways`.

```yaml
envoyGateway:
  enabled: true
  gatewayAPI:
    gateways:
      - name: hauke-cloud
        annotations:
          cert-manager.io/cluster-issuer: hauke-cloud
        listeners:
          - name: http
            protocol: HTTP
            port: 80
            allowedRoutes:
              namespaces:
                from: All
          - name: https-example
            protocol: HTTPS
            port: 443
            hostname: "*.example.com"
            allowedRoutes:
              namespaces:
                from: All
            tls:
              mode: Terminate
              certificateRefs:
                - kind: Secret
                  name: wildcard-example-com-tls
```

### The GatewayClass and Gateways appear on the second reconcile

Items 2 and 3 are rendered by *this* chart but need the CRDs that item 1
installs, so they are guarded by a capability check and skipped while those CRDs
are missing. Flux picks them up on the next reconcile once Envoy Gateway is
running. Set `envoyGateway.gatewayAPI.skipCapabilityCheck: true` to render them
unconditionally, which is what `helm template` runs need.

### Certificates and DNS

- **cert-manager** issues a certificate per HTTPS listener from the Gateway's
  `cert-manager.io/cluster-issuer` annotation, but only with its Gateway API
  support switched on -- see the commented `config.gatewayAPI` block under
  `certManager.values`. Do not enable it before the Gateway API CRDs exist;
  cert-manager fails to start without them.
- **external-dns** needs `gateway-httproute` added to `externalDNS.values.sources`
  next to `ingress`, so hostnames keep resolving from both while routes migrate.


## 📄 License

This Project is licensed under the GNU General Public License v3.0

- see the [LICENSE](LICENSE) file for details.


## :coffee: Contributing

To become a contributor, please check out the [CONTRIBUTING](CONTRIBUTING.md) file.


## :email: Contact

For any inquiries or support requests, please open an issue in this
repository or contact us at [contact@hauke.cloud](mailto:contact@hauke.cloud).

