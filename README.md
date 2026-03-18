# Overview 🍩

This git repository is for my homelab cluster called LISA. At my house we name our servers after the Simpsons. This project is a personal playground for learning and experimenting with Kubernetes, GitOps, and infrastructure tooling.

---

# Technology

## Nodes

Each node runs Ubuntu as the base OS with [k3s](https://k3s.io).

| Node        | Role   | RAM  | Disk  |
|-------------|--------|------|-------|
| lisa-master | Master | 16GB | 512GB |
| lisa-node-1 | Worker | 16GB | 512GB |
| lisa-node-2 | Worker | 16GB | 512GB |

## Currently Running

All applications are deployed via ArgoCD using an app-of-apps pattern. Manifests and Helm charts are defined in `argocd-applications/`.


| Component       | Purpose                                                                                                          | Logo                                             |
|-----------------|------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| ArgoCD          | Handles Continuous Delivery (CD) via GitOps. Specified manifests are synced from this repository to the cluster. | <img src="images/logo_argocd.png" height="100"/> |
| HashiCorp Vault | Runs on-cluster for secret management. Secrets are injected into pods via the Vault Agent sidecar.               | <img src="images/logo_vault.png" height="100"/>  |

## someday.md

Applications I hope to deploy. These are not in order by any means.

| Component                                                     | Purpose                                                                             |
|---------------------------------------------------------------|-------------------------------------------------------------------------------------|
| [Gatekeeper](https://github.com/open-policy-agent/gatekeeper) | Enforces policies on cluster resources via [OPA](https://www.openpolicyagent.org/). |
| [Ad Guard](https://github.com/AdguardTeam/AdGuardHome)        | Custom DNS server and network Ad-Blocker.                                           |
| [Authentik](https://github.com/goauthentik/authentik)         | Provides single sign-on for cluster services.                                       |
| [BookStack](https://github.com/BookStackApp/BookStack)        | Personal Wiki for all things LISA-related.                                          |
| [cert-manager](https://cert-manager.io/)                      | Automates TLS certificate lifecycle.                                                |


## File Structure

Current file structure of the repository.

```txt
lisa-cluster
├── argocd-applications # applications for argocd 
├── bootstrap # bootstrap yaml for app-of-app structure (argocd)
├── images # Images like diagrams & logos
├── manifests # custom manifests like points of ingress
└── policies # OPA policies 
```