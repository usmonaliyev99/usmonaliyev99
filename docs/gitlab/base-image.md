# Base image

To build helm package and use kubectl in ci pipeline, we have to install kubectl, helm, etc tools before start pipeline.

That is not good idea, that is why we created base image for it.

Open repository in gitlab like `k8s` or `helm`:

Create Dockerfile in it.

```yaml
FROM alpine:3.19

ARG KUBECTL_VERSION=v1.29.1
ARG HELM_VERSION=v3.14.1

# Base tools
RUN apk add --no-cache \
      curl \
      ca-certificates \
      tar \
      gzip

# Install kubectl
RUN curl -fsSL https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
      -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Install helm
RUN curl -fsSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz \
      | tar -xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && rm -rf linux-amd64

```

To build and push image, create `.gitlab-ci.yml` file:

```yaml
stages:
  - build

.build:
  stage: build
  before_script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$TAG .
    - docker push $CI_REGISTRY_IMAGE:$TAG
    - docker rmi $CI_REGISTRY_IMAGE:$TAG

build:latest:
  extends: .build
  variables:
    TAG: latest
  only:
    - main
```
