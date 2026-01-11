# Install minikube

**minikube** is local Kubernetes, focusing on making it easy to learn and develop for Kubernetes.

All you need is Docker (or similarly compatible) container or a Virtual Machine environment, and Kubernetes is a single command away: `minikube start`
What you’ll need

- 2 CPUs or more
- 2GB of free memory
- 20GB of free disk space
- Internet connection
- Container or virtual machine manager, such as: Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation

1. Installation

To install the latest minikube stable release on x86-64 Linux using binary download:

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

2. Start your cluster

From a terminal with administrator access (but not logged in as root), run:

```bash
minikube start
```

3. Enable ingress addon:

```bash
minikube addons enable ingress
```

4. Manage your cluster

Pause Kubernetes without impacting deployed applications:

```bash
minikube pause
```

Unpause a paused instance:

```bash
minikube unpause
```

Halt the cluster:

```bash
minikube stop
```

Change the default memory limit (requires a restart):

```bash
minikube config set memory 9001
```

Browse the catalog of easily installed Kubernetes services:

```bash
minikube addons list
```

Create a second cluster running an older Kubernetes release:

```bash
minikube start -p aged --kubernetes-version=v1.34.0
```

Delete all of the minikube clusters:

```bash
minikube delete --all
```

[Source](https://minikube.sigs.k8s.io/docs/start/)
