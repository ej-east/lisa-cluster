# Overview 🍩

This git repository is for my homelab cluster called LISA. At my house we name our servers after the Simpsons. This project is a personal playground for learning and experimenting with Kubernetes, GitOps, and infrastructure tooling.

---

# Architecture

## Nodes

Each node runs Ubuntu as the base OS with [k3s](https://k3s.io).

| Node        | Role   | RAM  | Disk  |
|-------------|--------|------|-------|
| lisa-master | Master | 16GB | 512GB |
| lisa-node-1 | Worker | 16GB | 512GB |
| lisa-node-2 | Worker | 16GB | 512GB |

---

## Network & Access

Traffic is both local-only and on the public internet. I use [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) as my DNS server. AdGuard allows for a DNS rewrite rule, meaning all `*.lisa` queries are forwarded to one of the node IPs. Every service gets a clean URL like `authentik.lisa` and `adguard.lisa`. For the Kubernetes DNS server, CoreDNS forwards all `*.lisa` queries to AdGuard, so pods inside the cluster can also resolve `*.lisa` domains. For my ingress controller I use [Traefik](https://traefik.io/traefik), which is the k3s default and works well for my setup. To get access from the outside internet to my internal cluster, I use a WireGuard proxy to forward traffic from an Oracle VM to my cluster.

### Internal Network

<img src="images/diagram_lisa-network-diagram.png"/>

### Public Access

<img src="images/diagram_lisa-proxy.png"/>

---

## Currently Running

All applications are deployed via ArgoCD using an app-of-apps pattern. Manifests and Helm charts are defined in `argocd-applications/`.

| Component                                                                           | Purpose                                                                                                                                                                                 | Logo                                                       |
|-------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [ArgoCD](https://github.com/argoproj/argo-cd)                                       | Handles Continuous Delivery (CD) via GitOps. Specified manifests are synced from this repository to the cluster.                                                                        | <img src="images/logo_argocd.png" height="100"/>           |
| [HashiCorp Vault](https://github.com/hashicorp/vault)                               | Runs on-cluster for secret management and PKI. Secrets are injected into pods via the Vault Agent sidecar.                                                                              | <img src="images/logo_vault.png" height="100"/>            |
| [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome)                          | Runs on-cluster for DNS management and ad blocking. DNS queries are filtered and resolved via customizable blocklists and upstream resolvers.                                           | <img src="images/logo_adguard.png" height="100"/>          |
| [cert-manager](https://cert-manager.io/)                                            | Runs on-cluster for certificate management. Certificates are automatically issued and renewed when ingress resources request them.                                                      | <img src="images/logo_cert-manager.png" height="100"/>     |
| [external-secrets](https://external-secrets.io/latest/)                             | Syncs secrets from HashiCorp Vault into Kubernetes-native Secret objects across workloads.                                                                                              | <img src="images/logo_external-secrets.png" height="100"/> |
| [cloudnative-pg](https://cloudnative-pg.io/)                                        | Manages PostgreSQL instances as Kubernetes-native resources with automated failover and backups.                                                                                        | <img src="images/logo_cloudnative-pg.png" height="100"/>   |
| [Authentik](https://github.com/goauthentik/authentik)                               | Handles Single Sign On (SSO) via OIDC and SAML configurations. Operates on-cluster as the centralized identity provider.                                                                                         | <img src="images/logo_authentik.png" height="100"/>        |
| [Gatekeeper](https://github.com/open-policy-agent/gatekeeper)                       | Enforces custom policies written in [rego](https://www.openpolicyagent.org/docs/policy-language). Manifests are dynamically validated against policies before admission to the cluster. | <img src="images/logo_opa.png" height="100"/>              |
| [Grafana & Prometheus](https://grafana.com/)                                        | Handles Monitoring and Observability. Metrics are collected by Prometheus, visualized through Grafana Dashboards, and alerted out via AlertManager.                                     | <img src="images/logo_grafana.png" height="100"/>          |
| [cheesedipper.com](https://cheesedipper.com)                                        | The website for [cheesedipper.com](https://cheesedipper.com). Built with Next.js and served via nginx.                                                                                  | <img src="images/logo_nginx.png" height="100"/>            |
| [blog.cheesedipper.com](https://blog.cheesedipper.com/)                             | The blog for the [cheesedipper](https://blog.cheesedipper.com/) domain. Built as a static site with Hugo and served via nginx.                                                          | <img src="images/logo_hugo.png" height="100"/>             |
| [WireGuard](https://www.wireguard.com/)                                             | VPN that connects an Oracle Cloud VM to the cluster for public ingress.                                                                                                                 | <img src="images/logo_wireguard.png" height="100"/>        |
| [Renovate](https://docs.renovatebot.com/)                                           | Automatically submits PRs for dependency updates.                                                                                                                                       | <img src="images/logo_renovate.png" height="100"/>         |
| [Umami](https://www.mintlify.com/umami-software/umami/self-hosting/getting-started) | Privacy-first analytics platform.                                                                                                                                                       | <img src="images/logo_umami.png" height="100"/>            |

## Design Decisions

### ArgoCD

Handles Continuous Delivery (CD) via GitOps. Specified manifests are synced from this repository to the cluster allowing this repository to act as the single source of truth.

I chose ArgoCD over Flux because of its built-in UI, stronger RBAC model, and generally more intuitive workflow. I didn't want to be manually running kubectl apply against the cluster. Instead, everything lives in Git, and ArgoCD makes sure the cluster matches.

### HashiCorp Vault

Runs on-cluster for secret management and PKI. Secrets are injected into pods via the Vault Agent sidecar.

I went with Vault over Sealed Secrets because Sealed Secrets didn't feel production-ready for what I needed. It has no real way to do secret rotation, and that was a dealbreaker. Vault gives me rotation, a proper PKI backend, and a foundation that scales if the cluster grows.

### External Secrets Operator

Syncs secrets from HashiCorp Vault into Kubernetes-native Secret objects across workloads.

Vault has its own sidecar injector, but ESO gives me more flexibility in how and where secrets get deployed. It also helps with separation Vault owns the secrets, ESO handles the delivery, and workloads stay simple.

### AdGuard Home

Runs on-cluster for DNS management and ad blocking. DNS queries are filtered and resolved via customizable blocklists and upstream resolvers.

AdGuard Home feels modern with polished controls, a clean UI, and built-in encrypted DNS support. I prioritized those things over what Pi-hole offers, like more advanced query logging and community plugins.

### cert-manager

Runs on-cluster for certificate management. Certificates are automatically issued and renewed when ingress resources request them.

cert-manager solves the kind of problem I'm most likely to forget. It pulls certificates from the local PKI (Vault) and automatically manages them for Ingress resources, so I never have to think about cert expiry.

### CloudNative-PG

Manages PostgreSQL instances as Kubernetes-native resources with automated failover and backups.

Authentik requires a PostgreSQL database. Instead of manually managing my own StatefulSet, I wanted something purpose-built and already refined. CloudNative-PG handles provisioning, failover, and backups out of the box.

### Authentik

Handles Single Sign On (SSO) via OIDC and SAML configurations. Operates on-cluster as the centralized identity provider.

I really wanted an IdP in my cluster. I used to manage Okta professionally (if you're curious), and after that experience I felt like I could never go back to not having centralized auth. Keycloak is the industry standard, but it felt bulky for a homelab. Authentik is lighter, has a great UI, and I wanted to try something newer.

### OPA Gatekeeper

Enforces custom policies written in [rego](https://www.openpolicyagent.org/docs/policy-language). Manifests are dynamically validated against policies before admission to the cluster.

Currently we have the following policies. These policies are set to warn.

| Policy                               | Description                                                      |
|--------------------------------------|------------------------------------------------------------------|
| `health-probe`                       | Pod must have a `livenessProbe` or `readinessProbe`              |
| `pod-automount-serviceaccount-token` | Pod must set `spec.automountServiceAccountToken` to false        |
| `resource-limits`                    | Pod must have resource limits                                    |
| `no-latest-image`                    | Pod must not use the `latest` image tag                          |
| `privileged-containers`              | Pod must not run with a privileged security context              |

---

## Security

### Network Policies

Currently there are no Network Policies. This means that the network is flat. Every pod can talk to every other pod. If one pod is compromised it can reach out to any of the databases within the cluster. This is where Network Policies come into play. You can define what namespaces are allowed to talk to other namespaces. Currently I run [K3s](https://k3s.io/) and by default it runs [flannel](https://github.com/flannel-io/flannel) as the CNI which does not support Network Policies. I plan on replacing K3s with [Talos](https://www.talos.dev/) down the road, which will support this.

### Pod Security Standards

[Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) define three different policies: privileged (unrestricted), baseline (prevents known privilege escalation), and restricted (hardening best practices). [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) enforces these policies at the namespace level. It can enforce, audit, and warn. For my custom deployments I use restricted and will continue to do so. For Helm charts I target baseline first and work towards restricted.

### Gatekeeper

Gatekeeper enforces custom security standards. I am slowly rolling it out based on the [NSA Kubernetes Hardening Guide](https://www.nsa.gov/Press-Room/News-Highlights/Article/Article/2716980/nsa-cisa-release-kubernetes-hardening-guidance/). `kubescape` will be used to scan from time-to-time.

### ServiceAccounts for Vault RBAC

Service Accounts for Vault are tightly scoped, only allowed to see secrets meant for them. For example the `authentik` service account can only see `authentik/` secrets. This is done via [Hashicorp Vault Policies](https://developer.hashicorp.com/vault/docs/concepts/policies)

---

## Backlog

Applications I want to deploy. These are not in order by any means.

| Component                                                                   | Purpose                                   |
|-----------------------------------------------------------------------------|-------------------------------------------|
| [BookStack](https://github.com/BookStackApp/BookStack)                      | Personal wiki for all things LISA-related |
| [Bitwarden](https://bitwarden.com/help/self-host-bitwarden/)                | Self-hosted password management           |
| [Paperless](https://docs.paperless-ngx.com/advanced_usage/#troubleshooting) | Digital document management               |
| [vert.sh](https://vert.sh/)                                                 | Locally hosted file conversions           |
| [Harbor](https://goharbor.io/)                                              | On-cluster container registry             |

---

## Repository Structure

```txt
.
├── argocd-applications # centralized argocd applications
├── bootstrap # bootstrap, defines app-of-apps for argocd
├── CHANGELOG.md # the changelog kept up to date by release-please
├── commitlint.config.mjs # commitlint rules
├── images # images and technical diagrams
├── manifests # additional customizations and custom deployments
├── policies  # policy-as-code lives here
├── README.md # the doc you are on
├── release-please-config.json # release-please config
├── renovate.json # renovate config
├── scripts # custom scripts
├── terraform # custom terraform to create instance
└── version.txt # version number kept up to date by release-please
```


---
