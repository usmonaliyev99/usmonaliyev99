# Installing Helm

## From the Binary Releases

Every [release](https://github.com/helm/helm/releases) of Helm provides binary releases for a variety of OSes. These binary versions can be manually downloaded and installed.

1. Download your [desired version](https://github.com/helm/helm/releases)
2. Unpack it (tar -zxvf helm-v4.0.0-linux-amd64.tar.gz)
3. Find the helm binary in the unpacked directory, and move it to its desired destination (mv linux-amd64/helm /usr/local/bin/helm)

## From Script

Helm now has an installer script that will automatically grab the latest version of Helm and install it locally.

You can fetch that script, and then execute it locally. It's well documented so that you can read through it and understand what it is doing before you run it.

```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh
```

Yes, you can `curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4 | bash` if you want to live on the edge.

## Commands

1. Render templates (no install)

```bash
helm template .
```

It shows **pure Kubernetes YAML**

```bash
helm template . \
  --set ingress.host=example.com \
  --set image.tag=123
```

You can overwrite default values.

2. Lint chart (static checks)

Finds syntax and logic errors

```bash
helm lint .
```

3. Install chart (first time)

```bash
helm install friend-backend .
```

- `friend-backend` → release name
- `.` → chart path

```bash
helm install friend-backend . \
    --set image.tag=3 \
    --set ingress.host=api.dev.local
```

With changes values.

4. Upgrade chart (most used)

Helm:

- compares current release
- applies only diffs

```bash
helm upgrade friend-backend .
```

Upgrade + install (CI-safe):

```bash
helm upgrade friend-backend . \
    --install \
    --set ingress.host=api.staging.local \
    --set image.tag=$CI_PIPELINE_IID
```

5. See installed releases

```bash
helm list
```

Namespace-specific:

```bash
helm list -n default
```

6. Inspect release values

```bash
helm get values friend-backend
```

[Source](https://helm.sh/docs/intro/install/)
