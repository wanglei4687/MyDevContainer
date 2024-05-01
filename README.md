# MyDevContainer

- based on
  - <https://github.com/alitari/vscode-remote-ohmyzsh/blob/master/.devcontainer/Dockerfile>
  - <https://github.com/deluan/zsh-in-docker/blob/master/Dockerfile>
  - <https://github.com/microsoft/vscode-dev-containers/blob/main/containers/debian/.devcontainer/base.Dockerfile>
  - [Pytorch Devcontainer](https://github.com/pytorch/pytorch/blob/main/.devcontainer/Dockerfile)
  - [devcontainer nvidia base](https://github.com/psaboia/devcontainer-nvidia-base)
  - [multi stage](https://github.com/docker/buildx/issues/805)


## Git SSH agent

- [Sharing git credentials](https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials)
- [Sharing ssh keys with devcontainer](https://dmsenter89.github.io/post/23-04-sharing-ssh-keys-with-devcontainer/)

## Dev Containers

### ML

- Cuda(wanglei4687/devcontainers:cuda12) linux/amd64
  - cuda 12.3
  - ubuntu22.04
  - torch torchvision torchaudio
  - ohmyzsh
- ML Cpu(wanglei4687/devcontainers:mlcpu) linux/amd64,linux/arm64
  -  miniconda
  - torch torchvision