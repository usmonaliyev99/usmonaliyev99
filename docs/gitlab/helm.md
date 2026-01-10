## Creating Your Own Charts

The[Chart Development Guide](https://helm.sh/docs/topics/charts) explains how to develop your own charts. But you can get started quickly by using the helm create command:

```bash
helm create f-backend-chart
cd f-backend-chart
```

Now there is a chart in ./f-backend-chart. You can edit it and create your own templates.

## Linting

As you edit your chart, you can validate that it is well-formed by running:

```bash
helm lint
```

## Package

When it's time to package the chart up for distribution, you can run:

```bash
helm package . -d output-folder
```

## Install

There are two way to install that chart.

1. With \*.tgz file:

```bash
helm install f-backend-app ./output-folder/f-backend-chart-0.1.0.tgz
```

2. Without tgz file, in development:

```bash
helm install f-backend-app .
```

## Upgrade

If you change that chart, you can upgrade your helm chart with:

```bash
helm upgrade f-backend .
```

## Uninstall

```bash
helm uninstall f-backend
```

Always delete resources with helm that created by helm

## Upload `tgz` file to gitlab server with API

```
curl --fail \
    --request POST \
    --user "$USER:$PASSWORD" \
    --form "chart=@./f-backend-chart-0.1.0.tgz" \
    "https://gitlab.example.com/api/v4/projects/$PROJECT_ID/packages/helm/api/stable/charts"
```
