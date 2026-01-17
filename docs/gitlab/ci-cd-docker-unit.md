# CI/CD for systemd docker

[First create systemd service.](./../docker/unit.md)

If you run your docker image with systemd, use this `.gitlab-ci.yml`:

```yaml
stages:
  - build
  - deploy

variables:
  TAG: prod

build:
  stage: build
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$TAG .
    - docker push $CI_REGISTRY_IMAGE:$TAG
    - docker rmi $CI_REGISTRY_IMAGE:$TAG || true
  only:
    - main

deploy:
  stage: deploy
  image: alpine:3.20
  before_script:
    - apk add --no-cache openssh
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts
  script:
    - ssh $SSH_USER@$SSH_HOST "docker pull $CI_REGISTRY_IMAGE:$TAG"
    - ssh $SSH_USER@$SSH_HOST "systemctl restart $SERVICE_NAME"
  only:
    - main
```
