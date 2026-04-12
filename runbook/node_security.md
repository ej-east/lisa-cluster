# Node Security Runbook

This doc covers the baseline security hardening applied to every node in this cluster.

All nodes are currently running Ubuntu.

## SSH Hardening

Default SSH configuration is too permissive for me. This section disables password auth, root login, and changes the standard login port.

### 1.1 Generate SSH Keys

Generate a dedicated key pair for cluster access:

```bash
ssh-keygen -t ed25519 -C "lisa-admin" -f ~/.ssh/lisa-key
```

Then copy it to each node:

```bash
ssh-copy-id -i ~/.ssh/lisa-key username@<node-ip>
```

Add an entry to your local `~/.ssh/config` so you're not typing flags every time:

```txt
Host lisa-<name>
  HostName <host-ip>
  User <username>
  IdentityFile ~/.ssh/lisa-key
  Port 2222

```

### 1.2 Harden `sshd_config`

This creates a hardening config into `/etc/ssh/sshd_config.d/99-hardening.conf` overriding defaults without touching the base file.

```bash
sudo vim /etc/ssh/sshd_config.d/99-hardening.conf
```

```txt
Port 2222
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
AllowUsers <username>
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
```

`ClientAliveInterval` and `ClientAliveCountMax` together mean an idle session gets dropped after ~10 minutes. `MaxAuthTries 3` limits brute force attempts before the connection is cut.

### 1.3 Test Access

Restart SSH. **Make sure to do this in a second terminal window so you don't lock yourself out.**

```bash
sudo systemctl daemon-reload
sudo systemctl restart ssh.socket
```

Then from the second terminal, confirm the new config works before closing anything:

```bash
ssh lisa-<name>
```

If it connects, you're good.

## UFW

### 2.1 Configure rules for Master Node

Log into the master node and run the following:

```bash
ssh lisa-master
```

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 2222/tcp          # SSH
sudo ufw allow 6443/tcp          # K3s API server
sudo ufw allow 10250/tcp         # Kubelet metrics

sudo ufw allow 8472/udp          # Cilium VXLAN
sudo ufw allow 51871/udp         # Cilium WireGuard
sudo ufw allow 4240/tcp          # Cilium health
sudo ufw allow 4244/tcp          # Hubble server
sudo ufw allow 4245/tcp          # Hubble relay

sudo ufw enable
```

### 2.2 Configure rules for Worker Node

Login to each worker node and run the following:

```bash
ssh lisa-node-#
```

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 2222/tcp          # SSH
sudo ufw allow 10250/tcp         # Kubelet
sudo ufw allow 30000:32767/tcp   # NodePort range

sudo ufw allow 8472/udp          # Cilium VXLAN
sudo ufw allow 51871/udp         # Cilium WireGuard
sudo ufw allow 4240/tcp          # Cilium health
sudo ufw allow 4244/tcp          # Hubble server
sudo ufw allow 4245/tcp          # Hubble relay

sudo ufw enable
```

### 2.3 Verify

Run on each node to verfiy:

```bash
sudo ufw status verbose
```

This should show you the rules above.

## Kernel Hardening

### sysctl config

```bash
sudo vim /etc/sysctl.d/99-hardening.conf
```

```conf
# IP Spoofing protection
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore ICMP broadcasts
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Disable source routing
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0

# SYN flood protection
net.ipv4.tcp_syncookies = 1

# Ignore redirect messages
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0

# Disable IPv6 -- not used in this cluster
net.ipv6.conf.all.disable_ipv6 = 1

# Prevent SUID binaries from dumping core
fs.suid_dumpable = 0

# ASLR -- randomize memory addresses
kernel.randomize_va_space = 2
```

### 3.2 K3s Kubelet params

```bash
sudo vim /etc/sysctl.d/90-kubelet.conf
```

Then paste:

```conf
vm.panic_on_oom=0        # Don't panic on OOM, let kubelet handle it
vm.overcommit_memory=1   # Allow memory overcommit -- required by k3s
kernel.panic=10          # Reboot 10s after a kernel panic
kernel.panic_on_oops=1   # Treat oops as panic
```

### Apply

```bash
sudo sysctl -p /etc/sysctl.d/90-kubelet.conf
sudo sysctl --system
```

## 4 K3s Config hardening

**Master node only.**

### 4.1 Edit K3s config

```bash
sudo vim /etc/rancher/k3s/config.yaml
```

```yaml
protect-kernel-defaults: true
secrets-encryption: true
kube-apiserver-arg:
  - "enable-admission-plugins=NodeRestriction"
  - "audit-log-path=/var/lib/rancher/k3s/server/logs/audit.log"
  - "audit-policy-file=/var/lib/rancher/k3s/server/audit.yaml"
  - "audit-log-maxage=30"
  - "audit-log-maxbackup=10"
  - "audit-log-maxsize=100"
kubelet-arg:
  - "streaming-connection-idle-timeout=5m"
  - "anonymous-auth=false"
```

### 4.2 Create audit log

```bash
sudo mkdir -p /var/lib/rancher/k3s/server/logs

sudo vim /var/lib/rancher/k3s/server/audit.yaml
```

```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
  - level: Metadata
```

### 4.3 Apply

```bash
sudo systemctl restart k3s
```

## Intrusion Detection

### 5.1 Fail2ban

Automatically bans IPs that fail to authenticate repeatedly.

```bash
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo vim /etc/fail2ban/jail.local
```

Find the `[sshd]` block and update it:

```toml
[sshd]
enabled = true
port    = 2222
logpath = %(sshd_log)s
backend = %(sshd_backend)s
maxretry = 3
bantime  = 1h
findtime = 10m
```

Then enable and start it:

```bash
sudo systemctl enable fail2ban --now
```

### 5.2 Automatic Security Updates

```bash
sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

Verify at `/etc/apt/apt.conf.d/50unattended-upgrades`; Make sure that security updates are uncommented

### 5.3 Disable Unused Services

Check out what is currently running:

```bash
sudo systemctl list-units --type=service --state=running
```

Disable any unused services:

```bash
sudo systemctl disable --now <service>
```
