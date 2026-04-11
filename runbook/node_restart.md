# Restarting Nodes

This doc covers how to safely restart Kubernetes nodes without causing disruption or down time to running services.


## Prepare Node for restart

### 1.1 Cordon the Node

Cordon marks the node as unschedulable. `kube-scheduler` won't schedule any new pods on it.

```bash
kubectl cordon <node-name>
```

### 1.2 Drain the Node

Gracefully evicts and reschedules pods.

```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

## Restart the Node

### 2.1 Login and Restart
```bash
ssh <node>
```

```bash
sudo reboot now
```

## Post-restart

### 3.1 Verify node is Ready
```bash
kubectl get nodes
```

### 3.2 Uncordon so the scheduler can place pods on it 

```bash
kubectl uncordon <node-name>
```