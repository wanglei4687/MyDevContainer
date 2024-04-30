# Docker iamges

## multi arch

- Just windows amd64 for now
- based on
  - <https://github.com/alitari/vscode-remote-ohmyzsh/blob/master/.devcontainer/Dockerfile>
  - <https://github.com/deluan/zsh-in-docker/blob/master/Dockerfile>
  - <https://github.com/microsoft/vscode-dev-containers/blob/main/containers/debian/.devcontainer/base.Dockerfile>
  - [Pytorch Devcontainer](https://github.com/pytorch/pytorch/blob/main/.devcontainer/Dockerfile)
  - [devcontainer nvidia base](https://github.com/psaboia/devcontainer-nvidia-base)
  - [multi stage](https://github.com/docker/buildx/issues/805)

create builder

```shell
docker buildx create --name mybuilder --use --bootstrap
```

build and push image

```shell
# amd64 
docker buildx build --platform linux/amd64 --load -t wanglei4687/dev-container:cuda12 dev/

# push registry 
docker buildx build --platform linux/amd64 --push -t wanglei4687/dev-container:cuda12 dev/
```

```shell
docker buildx build --platform linux/arm64 --load -t wanglei4687/dev-container:cuda12 -f ml/Dockerfile.cpu ml/ 
```