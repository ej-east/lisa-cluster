# LISA Cluster — Review & Roadmap

**Reviewed:** 2026-03-18
**Repo Age:** ~5 weeks (initial commit 2026-02-11, bulk of work done 2026-03-17 — 2026-03-18)
**Context:** 48 of 50 commits landed in a single ~24hr session. This is a very early-stage repo. Many of the items below are expected given the timeline — this is a roadmap, not a criticism.

---

## Critical Fixes (Do These First)

### Invalid Kubernetes Spec — AdGuard Deployment
`manifests/adguard/deployment.yaml` uses `spec.template.spec.node` which is **not a valid Kubernetes field**. This pod scheduling config will be rejected or silently ignored.

```yaml
# WRONG — current
spec:
  template:
    spec:
      node:
        node-name: lisa-node-2

# CORRECT — pick one:
# Option A: nodeSelector (simple)
      nodeSelector:
        kubernetes.io/hostname: lisa-node-2

# Option B: nodeName (hard pin, no scheduling flexibility)
      nodeName: lisa-node-2

# Option C: nodeAffinity (most flexible, preferred for production)
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: kubernetes.io/hostname
                operator: In
                values:
                - lisa-node-2
```
**Recommendation:** Use `nodeSelector` for now. Graduate to `nodeAffinity` later when you want soft preferences.

### Typo in Filename
`argocd-applications/agrocd-point-of-ingress.yaml` — rename to `argocd-point-of-ingress.yaml`.

### Pin AdGuard Image
`manifests/adguard/deployment.yaml` uses `adguard/adguardhome:edge`. Pin to a specific version tag (e.g., `v0.107.52`). The `edge` tag is a moving target and will eventually break something with no way to roll back.

### Remove `status: {}` Artifacts
`manifests/adguard/deployment.yaml` and `manifests/adguard/loadbalancer.yaml` both have `status: {}` at the bottom. These are artifacts from `kubectl create --dry-run` output. Remove them — `status` is server-managed and shouldn't be in source manifests.

---

## SSO

- [ ] **Vault SSO** — Configure Vault to use Authentik as an OIDC provider. This removes the need for Vault's root token / userpass auth for human access. Research Vault's `oidc` auth method.
- [ ] **ArgoCD SSO** — Configure ArgoCD to delegate login to Authentik via OIDC. ArgoCD supports this natively via `argocd-cm` ConfigMap (`oidc.config`). This also enables RBAC per-user in ArgoCD.
- [ ] **General SSO rollout** — Once Authentik is the IdP, every new service with a web UI should use it. Build a checklist/template for onboarding new apps to SSO.

---

## Branding

- [ ] **Custom logo** — Replace default ArgoCD and Authentik branding with LISA cluster identity. ArgoCD supports custom logos via `argocd-cm` ConfigMap (`ui.bannercontent`, `ui.cssurl`).
- [ ] **Color palette** — Define a consistent palette for the cluster's web UIs. Authentik supports theming natively. ArgoCD supports custom CSS.
- [ ] **Favicon / banner** — Small touch but makes it feel like a real platform rather than a default install.

---

## Network

### DNS
- [ ] **Document DNS resolution path** — How are `*.lisa` domains resolved? Is AdGuard handling this with DNS rewrites? If so, document the setup so it's reproducible. Right now, the repo deploys AdGuard but there's no config-as-code for its DNS rules.
- [ ] **AdGuard config backup** — Consider exporting AdGuard's config YAML and storing it in the repo (or at least documenting the manual steps). Currently the AdGuard deployment mounts PVCs but initial config is manual.
- [ ] **CoreDNS / split-horizon** — Document whether k3s CoreDNS is configured to forward `*.lisa` queries to AdGuard, or if this is handled at the router level.

### HTTPS
- [ ] **cert-manager is deployed but unused** — There are zero `Certificate` or `ClusterIssuer` resources in the repo. cert-manager is currently inert.
- [ ] **Create a ClusterIssuer** — For internal use, set up a self-signed CA or use Let's Encrypt with DNS-01 challenge (if you own a real domain). Minimum steps:
  1. Create a `ClusterIssuer` resource (self-signed or ACME)
  2. Update Traefik `IngressRoute` resources to add a `tls:` block
  3. Switch `entryPoints` from `web` to `websecure`
- [ ] **All ingress is currently HTTP-only** — Every `IngressRoute` uses `entryPoints: [web]`. This means Authentik (your SSO provider) serves login pages over plaintext. This should be the highest-priority network fix.

---

## Monitoring

- [ ] **Prometheus + Grafana stack** — Not deployed yet. Consider the `kube-prometheus-stack` Helm chart via ArgoCD. This gives you Prometheus, Grafana, Alertmanager, and node-exporter in one shot.
- [ ] **ArgoCD metrics** — ArgoCD already exposes Prometheus metrics. Wire them into Grafana once deployed.
- [ ] **Vault audit logs** — Enable Vault's audit backend and ship logs somewhere observable.
- [ ] **Alerting** — Even basic alerts (node down, pod crashlooping, certificate expiring) would be valuable. Alertmanager can send to Discord/Slack/email.
- [ ] **Traefik dashboard / metrics** — k3s bundles Traefik. Its dashboard and Prometheus metrics are likely already available but not exposed. Consider adding an `IngressRoute` for the Traefik dashboard and scraping its metrics.

---

## README Improvements

The current README lists *what* is deployed but not *why*. For a portfolio piece, the reasoning is more valuable than the inventory.

- [ ] **Why ArgoCD over Flux?** — What drove the GitOps tool choice?
- [ ] **Why k3s over k0s, microk8s, or full kubeadm?** — What tradeoffs were considered?
- [ ] **Why Vault over Sealed Secrets or SOPS?** — Vault is heavy for a homelab. What's the justification?
- [ ] **Why External Secrets Operator?** — Why not Vault Agent Injector directly? (The answer is probably "ESO is more Kubernetes-native" — say that.)
- [ ] **Why CloudNative-PG over a managed DB or plain StatefulSet?** — Good choice, explain it.
- [ ] **Why Authentik over Keycloak, Dex, or Authelia?** — These are all viable. What tipped the scale?
- [ ] **Why AdGuard over Pi-hole?** — Common question, worth addressing.
- [ ] **Architecture diagram** — A visual showing traffic flow (client → Traefik → service) and secret flow (Vault → ESO → K8s Secret → pod) would elevate the README significantly.

---

## Security

### Quick Wins
- [ ] **TLS everywhere** — (See HTTPS section above.) This is security item #1.
- [ ] **ArgoCD AppProject scoping** — All apps currently use `project: default` which has no RBAC boundaries. Create scoped AppProjects (e.g., `infrastructure`, `applications`) with destination/source restrictions.
- [ ] **Vault unsealing strategy** — Document how Vault is unsealed. Is it auto-unseal? Manual? If manual, what happens after a node restart? This is operationally critical.
- [ ] **Network Policies** — No NetworkPolicies exist. By default, every pod can talk to every other pod. At minimum, restrict Vault's ingress to only the pods/namespaces that need it.

### Research Needed
- [ ] **Pod Security Standards** — k3s supports Pod Security Admission (PSA). Research enforcing `restricted` or `baseline` profiles per namespace.
- [ ] **OPA / Gatekeeper** — Already on the someday list. Define what policies you'd enforce (no `latest` tags, required labels, resource limits, etc.).
- [ ] **RBAC audit** — Review what ServiceAccounts exist and what permissions they have. The `authentik` ServiceAccount has Vault access via Kubernetes auth — is the role scoped tightly?
- [ ] **Image scanning** — Consider Trivy or Grype in a CI pipeline to catch CVEs in container images before they hit the cluster.
- [ ] **Backup strategy** — What happens if a node's disk dies? PVCs for AdGuard and the Authentik DB have no backup. CloudNative-PG supports automated backups to S3 — enable it.

---

## Code Quality / Repo Hygiene

- [ ] **Pre-commit validation** — Add `kubeconform` or `kubeval` as a pre-commit hook or GitHub Action. This would have caught the `node:` spec error and many of the rapid-fire fix commits.
- [ ] **Consistent namespace handling** — Some ArgoCD apps specify `spec.destination.namespace`, others don't. Pick one pattern and stick with it.
- [ ] **Squash fix chains** — The AdGuard section has 12 fix commits in ~1 hour. In the future, use `--amend` or interactive rebase before pushing to keep history clean. (For this repo, it's fine to leave as-is — rewriting published history causes more problems than it solves.)
- [ ] **CI pipeline** — Even a basic GitHub Actions workflow that runs `kubeconform` on every push would catch most YAML errors before they hit ArgoCD.
- [ ] **`.gitignore`** — No `.gitignore` exists. Add one to prevent accidental commits of OS files, editor configs, or secrets.

---

## Priority Order

Given where the cluster is today, here's a suggested sequence:

1. **Fix the broken specs** (node selector, filename typo, image pin, status artifacts)
2. **HTTPS on all ingress** (cert-manager issuer + TLS on IngressRoutes)
3. **README: add the "why" sections** (biggest portfolio impact for minimal effort)
4. **ArgoCD SSO via Authentik** (proves the Authentik deployment actually works end-to-end)
5. **Monitoring stack** (Prometheus + Grafana — unlocks visibility for everything else)
6. **Pre-commit validation / CI** (prevents future fix-commit chains)
7. **Network Policies + Pod Security** (hardens the cluster)
8. **Branding** (lowest priority but fun)
