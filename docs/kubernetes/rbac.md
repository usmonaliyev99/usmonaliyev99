# RBAC

## Create service account

Create namespace for account:

```bash
kubectl create namespace prod
```

Create service account in that namespace:

```bash
kubectl create serviceaccount gitlab-prod-deployer -n prod
```

## Create role

Let's create deployer role:

```bash
kubectl create role deployer --verb get,list,watch,create,update,patch,delete --resource pods,deployments,services,ingress,configmaps,secrets,replicasets,endpoints -n prod
```

## Create role binding

Template:

```bash
kubectl create rolebinding <name> --serviceaccount <namespace>:<serviceaccount> --role <role-name> -n <namespace>
```

Example:

```bash
kubectl create rolebinding gitlab-prod-deployer --serviceaccount prod:gitlab-prod-deployer --role deployer -n prod
```

Check:

```bash
kubectl auth can-i list pods -n prod --as=system:serviceaccount:prod:gitlab-prod-deployer
```

- Yes => OK
- No => Something went wrong

## Create token

Template:

```bash
kubectl create token <serviceaccount> -n <namespace> --duration *h
```

```bash
# 1 year == 8760 hour

kubectl create token gitlab-prod-deployer -n prod --duration=8760h
```

## Generate deployer config

```yaml
apiVersion: v1
kind: Config
clusters:
  - cluster:
      server: https://<YOUR_SERVER_PUBLIC_IP>:6443
      certificate-authority-data: <BASE64_CA_CERT>
    name: <CLUSTER_NAME>
contexts:
  - context:
      cluster: <CLUSTER_NAME>
      namespace: <NAMESPACE>
      user: <SERVICE_ACCOUNT_NAME>
    name: <CONTEXT_NAME>
current-context: <CONTEXT_NAME>
users:
  - name: <SERVICE_ACCOUNT_NAME>
    user:
      token: <TOKEN_NEWLY_CREATED>
```

1. WHERE the cluster is (clusters)
2. WHAT you’re allowed to do & where (contexts)
3. WHO you are (users)

🔑 `certificate-authority-data`

```yaml
certificate-authority-data: <BASE64_CA_CERT>
```

This is:

- The CA certificate that signed your API server TLS cert
- Used to verify the server is trusted
- Prevents MITM attacks

Where to get it your admin cluster config (k3s.yaml or admin.conf)
