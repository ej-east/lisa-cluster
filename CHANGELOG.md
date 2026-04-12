# Changelog

## [0.5.0](https://github.com/ej-east/lisa-cluster/compare/v0.4.0...v0.5.0) (2026-04-12)


### Features

* **cilium:** init of cilium, added argocd application for cilium, adjusted node_security.md runbook ([#34](https://github.com/ej-east/lisa-cluster/issues/34)) ([b6d98a4](https://github.com/ej-east/lisa-cluster/commit/b6d98a4030a25ef33e7a331b5cb81e7b930e0cbb))


### Bug Fixes

* **cilium:** enable portmap CNI chaining for hostPort support ([cdbf057](https://github.com/ej-east/lisa-cluster/commit/cdbf05718424fed092d735fc376c398f60d2a6d7))
* **cilium:** use direct API server IP instead of auto discovery ([ecaa6f2](https://github.com/ej-east/lisa-cluster/commit/ecaa6f2ec56724fcdbfda58d310ff6bc4e01d055))
* **wireguard,cilium:** hotfix - disable KPR and wireguard encryption, fix tunnel DNAT routing ([2785f72](https://github.com/ej-east/lisa-cluster/commit/2785f72cb6de56500d1ec47f4187fbb97af094c2))
* **wireguard:** dnat to traefik pod endpoint resolved via k8s API ([bfbd0b9](https://github.com/ej-east/lisa-cluster/commit/bfbd0b9edbd41e34ce855e7955f7a72e0dec28da))
* **wireguard:** use direct API IP and retry loop for endpoint resolution ([baa4a72](https://github.com/ej-east/lisa-cluster/commit/baa4a72dbe553235306dbcc37099c68696e62a48))


### Reverts

* **cilium:** remove portmap CNI chaining, binary not installed ([9c8338a](https://github.com/ej-east/lisa-cluster/commit/9c8338a673a8536ce019bd0a03f4395981351204))


### Documentation

* **runbook:** added security & restarting runbook ([d45eeb2](https://github.com/ej-east/lisa-cluster/commit/d45eeb26e3a8a486f68df64faf176a0aeecd20db))

## [0.4.0](https://github.com/ej-east/lisa-cluster/compare/v0.3.2...v0.4.0) (2026-04-11)


### Features

* **memos:** init of memos application ([#31](https://github.com/ej-east/lisa-cluster/issues/31)) ([48ff033](https://github.com/ej-east/lisa-cluster/commit/48ff033f3ec5a1f7ecfb9587ee4dde3b928af159))

## [0.3.2](https://github.com/ej-east/lisa-cluster/compare/v0.3.1...v0.3.2) (2026-04-10)


### Chores

* **config:** migrate config renovate.json ([#22](https://github.com/ej-east/lisa-cluster/issues/22)) ([2d0968f](https://github.com/ej-east/lisa-cluster/commit/2d0968fdd2e73b42b82ad743965f3df66abb4a7a))

## [0.3.1](https://github.com/ej-east/lisa-cluster/compare/v0.3.0...v0.3.1) (2026-04-07)


### Bug Fixes

* file structure now matches expected design ([23363c4](https://github.com/ej-east/lisa-cluster/commit/23363c46d660e4494f8605d1527c1baac10e0361))


### Chores

* **deps:** update ghcr.io/renovatebot/charts/renovate docker tag to v46.103.0 ([#18](https://github.com/ej-east/lisa-cluster/issues/18)) ([6623ee4](https://github.com/ej-east/lisa-cluster/commit/6623ee4499cdbe4989a6a33fdf8e89e9d3b41e3e))
* **deps:** update helm release argo-cd to v9.4.17 ([#14](https://github.com/ej-east/lisa-cluster/issues/14)) ([ccdb535](https://github.com/ej-east/lisa-cluster/commit/ccdb535d5fb9969f0dc8c9693eee4780e348b6ca))
* **deps:** update helm release cert-manager to v1.20.1 ([#15](https://github.com/ej-east/lisa-cluster/issues/15)) ([564d967](https://github.com/ej-east/lisa-cluster/commit/564d967a5f005ed4b76e4882aa5f360c71cce197))
* **deps:** update helm release cloudnative-pg to v0.28.0 ([#16](https://github.com/ej-east/lisa-cluster/issues/16)) ([ae50db9](https://github.com/ej-east/lisa-cluster/commit/ae50db93ec41018072460e489ae3dfc180d5641a))
* **deps:** update helm release external-secrets to v2.2.0 ([#17](https://github.com/ej-east/lisa-cluster/issues/17)) ([0f89a22](https://github.com/ej-east/lisa-cluster/commit/0f89a220614492ddd60fb3fe31dafab01df50365))
* **deps:** update helm release kube-prometheus-stack to v82.18.0 ([#19](https://github.com/ej-east/lisa-cluster/issues/19)) ([358b4b3](https://github.com/ej-east/lisa-cluster/commit/358b4b392c33df92ca9c2a577c829228ed6f2237))
* **deps:** update helm release kube-prometheus-stack to v83 ([#20](https://github.com/ej-east/lisa-cluster/issues/20)) ([bace474](https://github.com/ej-east/lisa-cluster/commit/bace474487ad36a95b3d5d4306e254b8246dc2e5))

## [0.3.0](https://github.com/ej-east/lisa-cluster/compare/v0.2.0...v0.3.0) (2026-04-07)


### Features

* init of commitlinit for standarization ([#8](https://github.com/ej-east/lisa-cluster/issues/8)) ([138e947](https://github.com/ej-east/lisa-cluster/commit/138e9474deaf0ba55c0e08c4278ba2a14cd1c711))

## [0.2.0](https://github.com/ej-east/lisa-cluster/compare/v0.1.0...v0.2.0) (2026-04-07)


### Features

* added authentik ([900dffd](https://github.com/ej-east/lisa-cluster/commit/900dffd620db950c4c2c67a8f922b37741ad80c4))
* added authentik to cheesedipper ([3839d8f](https://github.com/ej-east/lisa-cluster/commit/3839d8f62e30b0a79464b54051f99fe372fcfc03))
* added Desgin Descisions + cleaned up readme ([5f5a8dd](https://github.com/ej-east/lisa-cluster/commit/5f5a8dd43a854ee95fe5e52d6bd4e787f18014c9))
* added domain to grafana ([db8989f](https://github.com/ej-east/lisa-cluster/commit/db8989f42f517685d30ca23f61a22f4714608392))
* added example app ([0a85687](https://github.com/ej-east/lisa-cluster/commit/0a856877d9b1fb3eca6b8f20d85e563ad322c684))
* added gitops for umami ([9c5bf4b](https://github.com/ej-east/lisa-cluster/commit/9c5bf4bfe53e6a3e127718088f813ff1d46c859b))
* added grafana to readme ([d9a2a54](https://github.com/ej-east/lisa-cluster/commit/d9a2a54a2512fd1cf4680ce0405ab9e23d806322))
* added lisa subdir foor cert-manager ([ccf8175](https://github.com/ej-east/lisa-cluster/commit/ccf8175394cb946f50d302a3f18e87b50ea99a19))
* added network diagram ([d2838d4](https://github.com/ej-east/lisa-cluster/commit/d2838d48a67e3f424f5de873e89132e71a013879))
* added opa/gatekeeper to README ([519737a](https://github.com/ej-east/lisa-cluster/commit/519737a8bb304e5d4745d8ee5094c01fc57d8fcb))
* added pod security admission to adguard ([a805de1](https://github.com/ej-east/lisa-cluster/commit/a805de1f665f41a8f4d1b7be67bbdf63e0e247a7))
* added postgres information ([84aedd4](https://github.com/ej-east/lisa-cluster/commit/84aedd4d3811cd38e3c57c1427923551ea2fcfef))
* added security section ([2879453](https://github.com/ej-east/lisa-cluster/commit/2879453ff80e3a5a24eae25cd95303655f0dd81e))
* added TLS to cheesedipper.com ([52705e4](https://github.com/ej-east/lisa-cluster/commit/52705e44bf7a3210d7b97f7837b4915ef23058f7))
* added wireguard to argocd ([fca85a3](https://github.com/ej-east/lisa-cluster/commit/fca85a3d16022a14b66367421dfe35d7164b0826))
* **adguard:** Added Admin Console to ingress ([a58c4dd](https://github.com/ej-east/lisa-cluster/commit/a58c4ddd130a9d9d950fb984a5e29f31b343f5b8))
* **adguard:** added loadbalancer and made adguard always on node 2 ([e1c195c](https://github.com/ej-east/lisa-cluster/commit/e1c195c909af8736bdd0d1f752ec3b53f73a31ef))
* **adguard:** init commit of adguard ([fa904fc](https://github.com/ej-east/lisa-cluster/commit/fa904fc77483e09926284209f0ca02a91ef75353))
* **argo-app:** created ingress application ([8e7fd87](https://github.com/ej-east/lisa-cluster/commit/8e7fd8768ed23d7742ee3f5f6bc70b4613e68d29))
* authentik ingress point ([05373ac](https://github.com/ej-east/lisa-cluster/commit/05373accb50615a9927511255d2e0eabd55015db))
* **cert-manager:** cert-manager init argocd-application ([b2ce7c9](https://github.com/ej-east/lisa-cluster/commit/b2ce7c96b525d786b7436c2f7a94ca679645d730))
* changing port to 443 ([d3e3955](https://github.com/ej-east/lisa-cluster/commit/d3e39553d935c074976bfe31e6d09958edcb1d14))
* configured database & changed file names ([f53c280](https://github.com/ej-east/lisa-cluster/commit/f53c2808e6f024b61f738dc82657e65132b12af1))
* create example tfvars file ([f2be734](https://github.com/ej-east/lisa-cluster/commit/f2be734e2d243fcc17f83bb766beca3a243e43cd))
* created argocd OIDC ([25c02f1](https://github.com/ej-east/lisa-cluster/commit/25c02f15661b5fcbb53a92ab8e0d9ef5bdee5ded))
* created base compute, data and modified networking ([aab0e77](https://github.com/ej-east/lisa-cluster/commit/aab0e773edb627dbd6f1e4ad5326de433a7bcfe2))
* created network file ([e5dbdfa](https://github.com/ej-east/lisa-cluster/commit/e5dbdfa4d53fbc08a27a2afbef8ec7fd2783d0b8))
* created output.tf ([99395cc](https://github.com/ej-east/lisa-cluster/commit/99395cc3e5711a9ba8ffeda72b6473606c4eda40))
* created pet name suffix ([3289a65](https://github.com/ej-east/lisa-cluster/commit/3289a65548dd36a6c4ef6789585d3156f3ea19ad))
* created readme ([ad45b59](https://github.com/ej-east/lisa-cluster/commit/ad45b598498e3d22fe7d70ba8fcf749876c24390))
* created root application for argocd ([ba7fd60](https://github.com/ej-east/lisa-cluster/commit/ba7fd608239cdf3f93dadc42ab6705e9e0837ad0))
* created wireguard client ([0e0d8c6](https://github.com/ej-east/lisa-cluster/commit/0e0d8c61c0a976c1fb433821fa9d9b601df82995))
* enable monitoring for argocd ([edde11b](https://github.com/ej-east/lisa-cluster/commit/edde11b172a1b22b89c18c931e178b85faf71f0f))
* https for adguard ([02a3d39](https://github.com/ej-east/lisa-cluster/commit/02a3d39f5166742e2a131a719b29f5990b47a14c))
* https for authentik ([7e3f834](https://github.com/ej-east/lisa-cluster/commit/7e3f834efccf760c6223e4360c65225480bb3598))
* https for hashicorp vault ([8821f19](https://github.com/ej-east/lisa-cluster/commit/8821f19020af84a5343f71e357c1f2f81d0dcac3))
* increased deployment security ([88fcc20](https://github.com/ej-east/lisa-cluster/commit/88fcc20dadbe38d88f5ce553eb238dda5811180a))
* **ingress:** created ingress points ([461e5e2](https://github.com/ej-east/lisa-cluster/commit/461e5e2d61cb2863a7def49245124e1961368d7b))
* init .gitignore ([3134d56](https://github.com/ej-east/lisa-cluster/commit/3134d568df161244b0d63c236f6141d9e73d4e5d))
* init create argoocd application ([0b7e3da](https://github.com/ej-east/lisa-cluster/commit/0b7e3daf7bbe606b148913eec6a6b0fd888f1ba2))
* init external secrets operator ([57bfc55](https://github.com/ej-east/lisa-cluster/commit/57bfc552a0430581bf2ff1b77c4a6addbb58280c))
* init ingress for grafana ([15a7313](https://github.com/ej-east/lisa-cluster/commit/15a731385153c586601675e7c304dd70f6d6e528))
* init of blog ([9144fc8](https://github.com/ej-east/lisa-cluster/commit/9144fc8b6d5e586228a8e578f810f56590c54e81))
* init of monitoring ([57d4c9b](https://github.com/ej-east/lisa-cluster/commit/57d4c9b2422b98d5d55ba59bee9815f4867d79e0))
* init of oci/random providers ([57586b2](https://github.com/ej-east/lisa-cluster/commit/57586b2fe362fef8ba5db8777397a312fae2cbd8))
* init of proxy compute ([5b6ee3e](https://github.com/ej-east/lisa-cluster/commit/5b6ee3edf90c1a05134cf000c521ed4be5bf4407))
* init of root site ([5d94079](https://github.com/ej-east/lisa-cluster/commit/5d9407977f778353272054a17893f57add7ab233))
* init on CA/https ([40f0d92](https://github.com/ej-east/lisa-cluster/commit/40f0d92abd63aeb6597b894d4a5f3ac07923533c))
* now we include root ca ([734fbf8](https://github.com/ej-east/lisa-cluster/commit/734fbf8273401fe270a865f90c5a604b6cf5ebed))
* now we use the password in vault ([aea6142](https://github.com/ej-east/lisa-cluster/commit/aea614251aa8dbb7c5996d4018a7c1e29a2438b8))
* oidc int + external secrets ([ecc2c3a](https://github.com/ej-east/lisa-cluster/commit/ecc2c3a2506a76bb6e53b1a6f73c675d05b937ad))
* pre-commits ([c1f7762](https://github.com/ej-east/lisa-cluster/commit/c1f77620e2a8785fc464167351a790c4cd104b3f))
* updated .gitignore ([b1df07f](https://github.com/ej-east/lisa-cluster/commit/b1df07fffddbdc30c19df71c68486d26839516c2))


### Bug Fixes

* added creationPolicy to external secret ([ca363ea](https://github.com/ej-east/lisa-cluster/commit/ca363eae5b46f637c16f0ef497e86da7751aa9b0))
* added postgresq_name ([510b966](https://github.com/ej-east/lisa-cluster/commit/510b96629aa164104321685382ce7b6cd9f7221f))
* added protocol ([e8504aa](https://github.com/ej-east/lisa-cluster/commit/e8504aa8956da864dda3ff2231b6c3cfde9caceb))
* added scheme + passthrough ([ebb98c2](https://github.com/ej-east/lisa-cluster/commit/ebb98c2c8fedeb50065fffa2753d7c0376c61de8))
* adguard and hashicorp opperate on non https ports ([7846fef](https://github.com/ej-east/lisa-cluster/commit/7846feffeea7c7814b3a5dae3684af90bb503389))
* **adguard:** added argocd sync wave ([be5865a](https://github.com/ej-east/lisa-cluster/commit/be5865a4113456df1f1945b440acd067120c7674))
* **adguard:** changed sync wave to pvc and deployment are at the same time ([d4ecd7b](https://github.com/ej-east/lisa-cluster/commit/d4ecd7ba72ff6991fe13459f084c117cc94519e3))
* **adguard:** fixed namespace for service ([9f3a358](https://github.com/ej-east/lisa-cluster/commit/9f3a35821075587c5708fe120ac5793c714ad9f4))
* **adguard:** indentation was incorrect ([5adcc7d](https://github.com/ej-east/lisa-cluster/commit/5adcc7d47339c9bae01a7c0cf95eaa8e9360dd0c))
* **adguard:** remove required health check for pvc ([57bd841](https://github.com/ej-east/lisa-cluster/commit/57bd841a9ccdf9fe01c933e69886e5b6265b1fd0))
* **adguard:** they need unq names ([5a87116](https://github.com/ej-east/lisa-cluster/commit/5a8711641b796da9b05927d92374bdf109ad8e9f))
* **adguard:** updated ingress name to match ([ee78dc4](https://github.com/ej-east/lisa-cluster/commit/ee78dc48148b32ffb526a5239d6ca402c686bd01))
* **adguard:** updated name to match ([0a86ac1](https://github.com/ej-east/lisa-cluster/commit/0a86ac1467bbec4650c37c6f5bbd1dc4935c1ce8))
* argocd does not support interpolation for rootCA ([61cc73f](https://github.com/ej-east/lisa-cluster/commit/61cc73f1a7e77156cd84853670bcf83569c183ac))
* auth should be a child of grafana.ini ([8a5538e](https://github.com/ej-east/lisa-cluster/commit/8a5538ea298c57a8e6882f5b77edc1365e245f69))
* authentik just passses in groups by default ([bc27994](https://github.com/ej-east/lisa-cluster/commit/bc279945bcc244daec1fd2af45f2ac8d2461e79d))
* **authentik:** fixed chart name ([8cffa9a](https://github.com/ej-east/lisa-cluster/commit/8cffa9ae9707e72945dceec5e2575747a810dc7c))
* **authentik:** removed beta from eso ([9c3fbfb](https://github.com/ej-east/lisa-cluster/commit/9c3fbfbdf04dc1eaeb4eb99840fef8d532cc33d1))
* **cert-manager:** change namespace for wildcard cert ([1a69550](https://github.com/ej-east/lisa-cluster/commit/1a6955048b52570be91fd9143dcf25e08157d6f7))
* changed ingressroute to ingressroutetcp ([c8ef609](https://github.com/ej-east/lisa-cluster/commit/c8ef6099fd07606749d7eef9732027c8db85184c))
* changed port & changed to http ([b937bb1](https://github.com/ej-east/lisa-cluster/commit/b937bb122655428c8aada96e34d85ca45e22aed8))
* corrected configs.cm ([55b0f24](https://github.com/ej-east/lisa-cluster/commit/55b0f248a0ba2276b77fdc2d28dec58302a6ea7b))
* corrected kubernetes ([aca1080](https://github.com/ej-east/lisa-cluster/commit/aca1080a6396989d58e030941c3272fc93532898))
* corrected namespace ([b760056](https://github.com/ej-east/lisa-cluster/commit/b760056b8d52fc30bc6a1fe0e034cbc57f1f5920))
* **db:** changed secret name ([c48c948](https://github.com/ej-east/lisa-cluster/commit/c48c948a6231acbcb0d9775e8b59e75edaa8393b))
* enable scheme + tls ([9e2553e](https://github.com/ej-east/lisa-cluster/commit/9e2553e85904be0478fe6765fe4af04d3849832b))
* **eso:** fixed external secrets operator ([2405463](https://github.com/ej-east/lisa-cluster/commit/2405463105f7f5f42dcb0958b947de382675aaa9))
* fixed minor issues ([b8509d1](https://github.com/ej-east/lisa-cluster/commit/b8509d1520f77e1f2bbb9648ee06963f727cbb42))
* fixed typo ([6d0df70](https://github.com/ej-east/lisa-cluster/commit/6d0df707e1ef96e09f985b64324d39b39126f1f3))
* forgot to spes repoURL ([064dd5d](https://github.com/ej-east/lisa-cluster/commit/064dd5dac256008697869c86e7ae4c61c050702d))
* **ingress:** allow argocd to use http ([5156a23](https://github.com/ej-east/lisa-cluster/commit/5156a23bf8a760b0c1673a1a97dbf7231b644f54))
* **ingress:** force argocd to use https ([afecf76](https://github.com/ej-east/lisa-cluster/commit/afecf768fb777da1e22d22154fc5c02d4bc79e20))
* it must be webSecure ([c6d3d26](https://github.com/ej-east/lisa-cluster/commit/c6d3d26d528b99bd59c1af6d9a6d62213ef5dc49))
* it needs a trailing slash ([f52d925](https://github.com/ej-east/lisa-cluster/commit/f52d925edb7baa3d48b937e67801c0871b49d150))
* it needs the trailing slash ([940e5de](https://github.com/ej-east/lisa-cluster/commit/940e5de8ce65a7ea436e6f3c46363b4525278e15))
* its lowercase `websecure` ([0799772](https://github.com/ej-east/lisa-cluster/commit/07997722c00890e303d212a6641131ee97fec96e))
* minor fixes with typos and other misspellings ([3a5ac99](https://github.com/ej-east/lisa-cluster/commit/3a5ac994210f9c3353fba0aa6a3454fd4b8c1437))
* only forward correct traffic ([a4644f0](https://github.com/ej-east/lisa-cluster/commit/a4644f0c6234e7ca10556e925f6fe3ab0f1db200))
* relax adguard security context for initial setup ([2502e83](https://github.com/ej-east/lisa-cluster/commit/2502e8334dca4440b9b775b90d86c55904472aaa))
* removed height from proxy for style points ([958ef01](https://github.com/ej-east/lisa-cluster/commit/958ef014d0f3a3e7d8314caca288d1cd0d57fb99))
* removed scheme + tls indent fix ([8c51cfe](https://github.com/ej-east/lisa-cluster/commit/8c51cfea37640437a0868da37b79c2650706abc5))
* rootCA should have been indented ([5487c33](https://github.com/ej-east/lisa-cluster/commit/5487c3355d30412169829e8191c6001656e33d06))
* secrets needs to be part of argocd ([f005ed6](https://github.com/ej-east/lisa-cluster/commit/f005ed62a9325e37ccc6f23992a22790dbbb8115))
* Switch back to ingressroute ([5e4fab8](https://github.com/ej-east/lisa-cluster/commit/5e4fab872f127cf1ee6914a0c969829cbf411a8a))
* this is meant to be a URL of itself ([9ad245a](https://github.com/ej-east/lisa-cluster/commit/9ad245ac6be583a129a6e1b7e79d061477dcaa0f))
* track correct subdir ([069abe3](https://github.com/ej-east/lisa-cluster/commit/069abe3a484f4628d7b9896a0da61ae5fc135458))
* update argocd-application to include secret-management ([c716b38](https://github.com/ej-east/lisa-cluster/commit/c716b384e0ae5ac3a245d3d4c6ac506a26781d45))
* updated `nodeSelector` to be correct ([4763169](https://github.com/ej-east/lisa-cluster/commit/47631698fd46cbfe53c22056e3edfde36849e959))
* updated client id mis match ([342926f](https://github.com/ej-east/lisa-cluster/commit/342926fe7df9bdb9dfc4fb6622b8bf01a4508407))
* updated port to be correct for adguard ([3c38edf](https://github.com/ej-east/lisa-cluster/commit/3c38edfe708db381918ef0b80cadfa29cb2cafd5))
* updated umami app name ([9889d43](https://github.com/ej-east/lisa-cluster/commit/9889d437c572c8ac836fb43f357b14c314785774))
* updated umami app name ([c357907](https://github.com/ej-east/lisa-cluster/commit/c357907fc09efc7f4c45df2a69d6fe14a61b4c4a))
* use internal DNS ([3808ced](https://github.com/ej-east/lisa-cluster/commit/3808cedde5b332b648fdbde3ee33be212ab53660))
* **vault:** Removed unneeded prefix ([56cd4ce](https://github.com/ej-east/lisa-cluster/commit/56cd4ce4181626bbd08457ed87ecb8374e6bd622))


### Styling

* added paperless to someday.md. did formatting on tables ([2293e75](https://github.com/ej-east/lisa-cluster/commit/2293e757074320406f624b04d6d08a46545940fa))
* applied formatting ([f345a69](https://github.com/ej-east/lisa-cluster/commit/f345a699d0e5733d4f576cc0a7e79b18ee9c66c0))
* fixed minor heading markdown violations ([b80bc33](https://github.com/ej-east/lisa-cluster/commit/b80bc332bd6b3e66447d47225331c3dfe47c8324))
* fmt markdown tables ([4640bdf](https://github.com/ej-east/lisa-cluster/commit/4640bdf3bef0f1b9cb25d13ec0086768d846f179))
* formatted md table ([103ed38](https://github.com/ej-east/lisa-cluster/commit/103ed385f34b869b2ae953a857fc901a6534d898))
* made cpu limit a string ([936a757](https://github.com/ej-east/lisa-cluster/commit/936a75724f5bfa2fe15d8f987c69e689f7f3dd3e))
* ran yamlfmt ([1320f8e](https://github.com/ej-east/lisa-cluster/commit/1320f8e7a60058ebf43445a933dff3f759140445))
* removed trailing / on authentik ([b9a252d](https://github.com/ej-east/lisa-cluster/commit/b9a252dd144c0ed5f6c10f0fbfda929a78190b33))
* removed trailing slash ([ad7f0fd](https://github.com/ej-east/lisa-cluster/commit/ad7f0fd30429c1ccd4e47b448e0d56792aec5a09))
* update secret target name ([34d797d](https://github.com/ej-east/lisa-cluster/commit/34d797d5f6bdb56b97c8e6d5070e5073369c4b5a))
* updated readme with new components ([494dde9](https://github.com/ej-east/lisa-cluster/commit/494dde958e569a47c5074561fb7e9a2a14c68459))


### Chores

* add adguard to dnsNames ([fc925c9](https://github.com/ej-east/lisa-cluster/commit/fc925c92a8aa673fc0452401cca376541c93ad54))
* add tf lock ([83ca4e6](https://github.com/ej-east/lisa-cluster/commit/83ca4e60e3833430fe508c78f99f42942a48a3db))
* added argo.lisa to common name ([d2a38c4](https://github.com/ej-east/lisa-cluster/commit/d2a38c4edf7d7de74b2925e0accd83439cf07b2b))
* added cheesedipper to gitops ([339eb0e](https://github.com/ej-east/lisa-cluster/commit/339eb0e6864f6389a919a3536546e377d51a4b0f))
* added file structure ([062fd2c](https://github.com/ej-east/lisa-cluster/commit/062fd2cd491d23e6b29191facaf5794d19d5ffab))
* added other services to wildcard ([515abb3](https://github.com/ej-east/lisa-cluster/commit/515abb3d69bb3a3517aef678ab0203856497c02b))
* **adguard:** added adguard to currently running ([198cdb2](https://github.com/ej-east/lisa-cluster/commit/198cdb2d06d1f0a903d5c80003fa8b1dbe31653a))
* **adguard:** pinned version on deployment ([4b83256](https://github.com/ej-east/lisa-cluster/commit/4b83256e357147afbe10f7ec3621176b558aae57))
* **adguard:** updated namespace so ingress works ([349a94a](https://github.com/ej-east/lisa-cluster/commit/349a94ad0182f5230e78c74d266a7aa3c1541c85))
* apply server side for external ([9b88b27](https://github.com/ej-east/lisa-cluster/commit/9b88b2725de9929eb28342022e44d3628ff77bc6))
* **argocd:** Added Argo Application ([6e12447](https://github.com/ej-east/lisa-cluster/commit/6e124472ae8584bcb37b1dccecf4596b4494a512))
* **argocd:** added clientID and rootCA to hashicorp vault ([ea10edb](https://github.com/ej-east/lisa-cluster/commit/ea10edbecc1686afb1a7cc3630dc555ed83c551d))
* bootstrap release-please ([89136d8](https://github.com/ej-east/lisa-cluster/commit/89136d87e41dadce6c67c2684e90264b92d14ef0))
* bootstrap release-please ([49fc4db](https://github.com/ej-east/lisa-cluster/commit/49fc4db2eba060ffd175df9a115e5a8598c2a9b1))
* **cert-manager:** updated readme ([b907cdb](https://github.com/ej-east/lisa-cluster/commit/b907cdb2ab3194672d9638bf040a009d3893b51b))
* corrected file name ([31e0dd7](https://github.com/ej-east/lisa-cluster/commit/31e0dd7b92bcdb93256162a093a6eee734876762))
* **filesystem:** Made sub-folder fo ingress ([79b5520](https://github.com/ej-east/lisa-cluster/commit/79b552051db27b3c1ec1faddfc04501045e08b83))
* **grafana:** added oidc id to hashicorp vault ([7d44a23](https://github.com/ej-east/lisa-cluster/commit/7d44a23da9811a6d49c307403602947dc2d87cb8))
* made admins, admins ([ec9252b](https://github.com/ej-east/lisa-cluster/commit/ec9252b8b6d5d7636a42b87218a7e8f9a93f24a7))
* now always pulls image ([8bc3af8](https://github.com/ej-east/lisa-cluster/commit/8bc3af8f52022d8e4fc6695a08d0244c3dc3eb2f))
* ReadMe update ([6e1b464](https://github.com/ej-east/lisa-cluster/commit/6e1b464727fb059a7e59b55b5e61579a7a0286f3))
* **readme:** added future tools ([d0863d2](https://github.com/ej-east/lisa-cluster/commit/d0863d2e8602f63dc722361640b0a0956d36ab1b))
* **readme:** Readme updates ([4027296](https://github.com/ej-east/lisa-cluster/commit/40272965dfec50869260aa247354d8cab33e37e7))
* **readme:** Updated README ([b0f5305](https://github.com/ej-east/lisa-cluster/commit/b0f5305febb13f26a5d93c75ef91d8832a4e0c7a))
* **readme:** updated size of logos ([01c7f5d](https://github.com/ej-east/lisa-cluster/commit/01c7f5dc43063979828b897aefbe59eed5ffce0d))
* remove authentik ([3b009f4](https://github.com/ej-east/lisa-cluster/commit/3b009f4886cf12996767bf3db7d17fb2a278a77d))
* removed default values ([a764b22](https://github.com/ej-east/lisa-cluster/commit/a764b22267ec3b14d1668a3e55cab0ba11db6375))
* removed grafana from Backlog ([37fb232](https://github.com/ej-east/lisa-cluster/commit/37fb2323f8b6f44b6f282cfd6e9a6be9e1947ac6))
* removed init container ([6778a23](https://github.com/ej-east/lisa-cluster/commit/6778a23c3682fd38f883b9b4e509f86bc507a3eb))
* removed REVIEW.md from tracking ([bcb03b1](https://github.com/ej-east/lisa-cluster/commit/bcb03b144ab4125ee6008fcad39d3037c139a837))
* removed uneed row in table ([ada96a2](https://github.com/ej-east/lisa-cluster/commit/ada96a2b453e7660e5cc767f3d496aac6b083d25))
* **status:** removed undeeded status block ([e251e92](https://github.com/ej-east/lisa-cluster/commit/e251e922477dae227ae03611c7c9dacccc035cf5))
* update argo to be on cheesedipper.com ([e6d6324](https://github.com/ej-east/lisa-cluster/commit/e6d63248752b2dd85cf78ea634a83af6815d8239))
* update filename to terraform.tfvars.example ([01e29d8](https://github.com/ej-east/lisa-cluster/commit/01e29d86f374d08457c270eac21382a4e7da996f))
* update grafana oidc ([366a3b8](https://github.com/ej-east/lisa-cluster/commit/366a3b88797bcd2d40fa2ffb717d1d703aa01779))
* update grafana to be on cheesedipper.com ([509a301](https://github.com/ej-east/lisa-cluster/commit/509a301b657ed1cc151bdd3a49702b8481283eab))
* update grafana values to be cheesedipper ([782cdb0](https://github.com/ej-east/lisa-cluster/commit/782cdb02d76966f3bd6bb10db2c77ba0094ec5bd))
* update hashicorp vault to be on cheesedipper domain ([09e3ef2](https://github.com/ej-east/lisa-cluster/commit/09e3ef2d090b8923665c32d1001639288b5c2f96))
* update image to be correct ([6371489](https://github.com/ej-east/lisa-cluster/commit/6371489948f743060e41910749e12efde7f95aac))
* update readme repo structure ([c0135d7](https://github.com/ej-east/lisa-cluster/commit/c0135d7c454dbf99f1e781b0dc1d4d6aa088296a))
* update TLS to correct cert ([70ca627](https://github.com/ej-east/lisa-cluster/commit/70ca6279017325bcd162f57521bbb8ef9b5e592a))
* updated README.md ([b59df1b](https://github.com/ej-east/lisa-cluster/commit/b59df1b5c53892bba627cc8653cf457741cd8648))
* updated to match new authentik URL ([f934c17](https://github.com/ej-east/lisa-cluster/commit/f934c17e25bb99bd25d4c6bdbb91b09f4f22b50d))
