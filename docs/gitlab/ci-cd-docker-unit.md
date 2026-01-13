# CI/CD for systemd docker

If you run your docker image with systemd, use this `.gitlab-ci.yml`:

```yaml
stages:
  - build
  - deploy

build:
  stage: build
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID .
    - docker tag $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID $CI_REGISTRY_IMAGE:prod
    - docker push $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID
    - docker push $CI_REGISTRY_IMAGE:prod
    - docker rmi $CI_REGISTRY_IMAGE:prod || true
    - docker rmi $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID || true
  only:
    - main

deploy:
  stage: deploy
  image: alpine:3.20
  variables:
    SERVICE_NAME: f-backend.service
  before_script:
    - apk add --no-cache openssh
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan $SSH_HOST >> ~/.ssh/known_hosts
  script:
    - ssh $SSH_USER@$SSH_HOST "docker pull $CI_REGISTRY_IMAGE:$CI_PIPELINE_IID"
    - ssh $SSH_USER@$SSH_HOST "sudo systemctl restart $SERVICE_NAME"
  only:
    - main
```
