# MyDevContainer

- <https://github.com/alitari/vscode-remote-ohmyzsh/blob/master/.devcontainer/Dockerfile>
- <https://github.com/deluan/zsh-in-docker/blob/master/Dockerfile>
- <https://github.com/microsoft/vscode-dev-containers/blob/main/containers/debian/.devcontainer/base.Dockerfile>
- [Pytorch Devcontainer](https://github.com/pytorch/pytorch/blob/main/.devcontainer/Dockerfile)
- [devcontainer nvidia base](https://github.com/psaboia/devcontainer-nvidia-base)
- [multi stage](https://github.com/docker/buildx/issues/805)

## Git SSH agent

- [Sharing git credentials](https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials)
- [Sharing ssh keys with devcontainer](https://dmsenter89.github.io/post/23-04-sharing-ssh-keys-with-devcontainer/)

## Proxy

- [github proxy](https://ghgo.xyz/)

## Test

docker gpu support

```shell
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```