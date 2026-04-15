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

Traffic is both local and on the public internet. I use [AdGuard Home](https://adguard.com/en/adguard-home/overview.html) as my DNS server. AdGuard allows for a DNS rewrite rule, meaning all `*.lisa` queries are forwarded to one of the node IPs. Every service gets a clean URL like `authentik.lisa` and `adguard.lisa`. For the Kubernetes DNS server, CoreDNS forwards all `*.lisa` queries to AdGuard, so pods inside the cluster can also resolve `*.lisa` domains. For my ingress controller I use [Traefik](https://traefik.io/traefik), which is the k3s default and works well for my setup. However I do not use the default CNI, *flannel*, instead I use Cilium; a more production choice for security, observability, and policy enforcement. To get access from the outside internet to my internal cluster, I use a WireGuard proxy to forward traffic from an Oracle VM to my cluster.

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
| [Authentik](https://github.com/goauthentik/authentik)                               | Handles Single Sign On (SSO) via OIDC and SAML configurations. Operates on-cluster as the centralized identity provider.                                                                | <img src="images/logo_authentik.png" height="100"/>        |
| [Gatekeeper](https://github.com/open-policy-agent/gatekeeper)                       | Enforces custom policies written in [rego](https://www.openpolicyagent.org/docs/policy-language). Manifests are dynamically validated against policies before admission to the cluster. | <img src="images/logo_opa.png" height="100"/>              |
| [Grafana & Prometheus](https://grafana.com/)                                        | Handles Monitoring and Observability. Metrics are collected by Prometheus, visualized through Grafana Dashboards, and alerted out via AlertManager.                                     | <img src="images/logo_grafana.png" height="100"/>          |
| [cheesedipper.com](https://cheesedipper.com)                                        | The website for [cheesedipper.com](https://cheesedipper.com). Built with Next.js and served via nginx.                                                                                  | <img src="images/logo_nginx.png" height="100"/>            |
| [blog.cheesedipper.com](https://blog.cheesedipper.com/)                             | The blog for the [cheesedipper](https://blog.cheesedipper.com/) domain. Built as a static site with Hugo and served via nginx.                                                          | <img src="images/logo_hugo.png" height="100"/>             |
| [WireGuard](https://www.wireguard.com/)                                             | VPN that connects an Oracle Cloud VM to the cluster for public ingress.                                                                                                                 | <img src="images/logo_wireguard.png" height="100"/>        |
| [Renovate](https://docs.renovatebot.com/)                                           | Automatically submits PRs for dependency updates.                                                                                                                                       | <img src="images/logo_renovate.png" height="100"/>         |
| [Umami](https://www.mintlify.com/umami-software/umami/self-hosting/getting-started) | Privacy-first analytics platform.                                                                                                                                                       | <img src="images/logo_umami.png" height="100"/>            |
| [Memos](https://usememos.com/)                                                      | Self hosted application for quick notes and snippets.                                                                                                                                   | <img src="images/logo_memos.png" height="100"/>            |
| [Cilium](https://cilium.io/)                                                        | eBPF-based CNI. Handles NetworkPolicy enforcement, and Hubble observability.                                                                                                              | <img src="images/logo_cilium.png" height="100"/>           |

---

## Terraform & Oracle Cloud

My cluster sits behind my home network and I wanted public access without exposing ports on my router. This posed a unique challenge. I decided to use a public-facing VM to act as a proxy and forward traffic to my cluster.

Terraform provisions an instance that has a public-facing static IP address running WireGuard as an entry point into my home network. I use Oracle Cloud's always-free tier which gives me an ARM VM at zero cost.

---

## Design Decisions

### GitOps & Delivery

#### ArgoCD

I chose ArgoCD over Flux because of its built-in UI, stronger RBAC model, and generally more intuitive workflow. I didn't want to be manually running kubectl apply against the cluster. Instead, everything lives in Git, and ArgoCD makes sure the cluster matches.

#### Renovate

Renovate handles a problem commonly found in patching containers. Updating them. Updating a container isn't hard work however it's tedious to have to keep track of all dependencies, and compare which ones need to be updated. Renovate solves this issue.

### Secrets & Identity

#### HashiCorp Vault

I went with Vault over Sealed Secrets because Sealed Secrets didn't feel production-ready for what I needed. It has no real way to do secret rotation, and that was a dealbreaker. Vault gives me rotation, a proper PKI backend, and a foundation that scales if the cluster grows.

#### External Secrets Operator

Vault has its own sidecar injector, but ESO gives me more flexibility in how and where secrets get deployed. It also helps with separation -- Vault owns the secrets, ESO handles the delivery, and workloads stay simple.

#### cert-manager

cert-manager solves the kind of problem I'm most likely to forget. It automatically talks with Cloudflare to beat the Let's Encrypt DNS01 challenge. This is important; everyone who has a domain should be using it.

#### Authentik

I really wanted an IdP in my cluster. I used to manage Okta professionally (if you're curious), and after that experience I felt like I could never go back to not having centralized auth. Keycloak is the industry standard, but it felt bulky for a homelab. Authentik is lighter, has a great UI, and I wanted to try something newer.

### Networking & Security

#### OPA Gatekeeper

OPA Gatekeeper enforces standards I have set across the cluster. It is an easy way to figure out what can be improved from an operational and security perspective. It is also an easy way to make sure that it stays that way.

Currently we have the following policies. These policies are set to warn.

| Policy                               | Description                                               |
|--------------------------------------|-----------------------------------------------------------|
| `health-probe`                       | Pod must have a `livenessProbe` or `readinessProbe`       |
| `pod-automount-serviceaccount-token` | Pod must set `spec.automountServiceAccountToken` to false |
| `resource-limits`                    | Pod must have resource limits                             |
| `no-latest-image`                    | Pod must not use the `latest` image tag                   |
| `privileged-containers`              | Pod must not run with a privileged security context       |

#### Cilium

Cilium is the gold standard for CNIs. Almost every company uses it whether they realize it or not; EKS uses it as the default CNI. So it felt like an obvious choice and a great way to get some hands-on practice.

### Data & Storage

#### CloudNative-PG

Lots of applications require some sort of database. Instead of manually managing my own StatefulSets, I wanted something purpose-built and already refined. CloudNative-PG handles provisioning, failover, and backups out of the box.

### Observability

#### Grafana & Prometheus

Having visibility into your cluster is almost as important as building it. Knowing what is breaking when not only helps with the troubleshooting process but also maintaining operational excellence. More importantly, it lets us think about Day 2.

#### Hubble

Hubble is extremely important in the context of network security. Hubble allows you to see which pods are talking to which namespaces. This lets you define a baseline of what needs to talk to what and write NetworkPolicies accordingly.

### Applications

#### AdGuard Home

AdGuard Home feels modern with polished controls, a clean UI, and built-in encrypted DNS support. I prioritized those things over what Pi-hole offers, like more advanced query logging and community plugins.

#### Memos

I love writing, it's the way I plan and relieve stress. I was using Obsidian before for this task but felt like I was locked to my computer. So I looked for a note taking application I could host on my cluster and Memos was the best choice.

#### cheesedipper.com & blog

The main website is built with Next.js and served via nginx, and the blog is a static site built with Hugo. Having them in the cluster means I control the full stack from build to delivery.

#### Umami

Knowing who is looking at your work and more importantly, what they look at is important. Google Analytics is one way to do this but is often blocked by privacy browsers. Umami allows me to host my own analytics stack without handing data over to Google.

---

## Security

### Node Hardening

Right now my nodes run on Ubuntu and I have taken the time to harden them. In the table below I have listed what I have hardened. If you'd like to see how I hardened each thing feel free to checkout the [runbook](runbook/node_security.md).

| Category             | How was it hardened                                                                   |
|----------------------|---------------------------------------------------------------------------------------|
| SSH Hardening        | Key type is ed25519, Disabled password auth, Maximum of 3 tries, Changed port to 2222 |
| UFW firewall rules   | Differing firewall rules for master and worker nodes                                  |
| Kernel Hardening     | IP spoofing protection, SYN cookies, ASLR, IPv6 disabled                              |
| K3s API hardening    | Audit logging, Secrets encryption, NodeRestriction Admission                          |
| Intrusion detection | Fail2ban & Unattended Security Upgrades                                               |

### Network Policies

Currently there are no Network Policies. This means that the network is flat. Every pod can talk to every other pod. If one pod is compromised it can reach out to any of the databases within the cluster. This is where Network Policies come into play. You can define what namespaces are allowed to talk to other namespaces. I recently installed [cilium](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/), which supports network policies. I plan on slowly rolling this out over the next few weeks. I am waiting to capture what is normal traffic and what is expected to talk to each other.

### Pod Security Standards

[Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) define three different policies: privileged (unrestricted), baseline (prevents known privilege escalation), and restricted (hardening best practices). [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) enforces these policies at the namespace level. It can enforce, audit, and warn. For my custom deployments I use restricted and will continue to do so. For Helm charts I target baseline first and work towards restricted.

### Gatekeeper

Gatekeeper enforces custom security standards. I am slowly rolling it out based on the [NSA Kubernetes Hardening Guide](https://www.nsa.gov/Press-Room/News-Highlights/Article/Article/2716980/nsa-cisa-release-kubernetes-hardening-guidance/). `kubescape` will be used to scan from time-to-time.

### ServiceAccounts for Vault RBAC

Service Accounts for Vault are tightly scoped, only allowed to see secrets meant for them. For example the `authentik` service account can only see `authentik/` secrets. This is done via [Hashicorp Vault Policies](https://developer.hashicorp.com/vault/docs/concepts/policies).

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
├── .github                # GitHub workflows and configuration
├── argocd-applications    # centralized argocd applications
├── bootstrap              # bootstrap, defines app-of-apps for argocd
├── CHANGELOG.md           # changelog kept up to date by release-please
├── commitlint.config.mjs  # commitlint rules
├── images                 # images and technical diagrams
├── manifests              # additional customizations and custom deployments
├── policies               # policy-as-code lives here
├── README.md              # the doc you are on
├── release-please-config.json # release-please config
├── renovate.json          # renovate config
├── runbook                # operational runbooks (node security, restarts)
├── scripts                # custom scripts
├── terraform              # terraform for Oracle Cloud VM provisioning
└── version.txt            # version number kept up to date by release-please
```


---
