# Overview 🍩

This git repo is for my homelab cluster called LISA. At my house we name our servers after the Simpsons. This project is meant to be a useful playground for myself. To help me improve and build upon my Kubernetes skills.

---

# Technology

## Nodes

Nodes run Ubuntu and k3.

| Node        | Role   | RAM  | Disk  |
|-------------|--------|------|-------|
| lisa-master | Master | 16GB | 512GB |
| lisa-node-1 | Worker | 16GB | 512GB |
| lisa-node-2 | Worker | 16GB | 512GB |

## Currently Running

| Tool | Component | Logo | 
|------|----------|-------|
| ArgoCD | GitOps | <img src="images/logo_argocd.png" height="24"/> | 
| HashiCorp Vault | Secret Management | <img src="images/logo_vault.png" height="24"/> | 

## someday.md

Applications I hope to deploy or problems I hope to fix. 

- Gatekeeper
- Ad Guard
- TLS/https
- Authentik
- BookStack


## File Structure

```txt
lisa-cluster
├── argocd-applications # applications for argocd 
├── bootstrap # bootstrap yaml for app-of-app structure (argocd)
├── images # Images like diagrams & logos
├── manifests # custom manifests like points of ingress
└── policies # OPA policies 
```