FROM ubuntu:22.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG NAME="CPP"
ARG SCOPE="DEVCONTAINERS"

LABEL NAME=${NAME}
LABEL SCOPE=${SCOPE}

ENV TZ Asia/Shanghai 
ENV DEBIAN_FRONTEND noninteractive

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME 

RUN apt update

# Install dependency
RUN apt install -y sudo wget software-properties-common curl \
    git vim zsh gnupg2 libssl-dev autoconf libtool iputils-ping netcat-openbsd\
    locales \
    # set up locale
    && locale-gen en_US.UTF-8

# https://apt.llvm.org/
RUN apt install -y clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python3-clang

# Install miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
RUN /bin/bash /tmp/miniconda.sh -b -p /home/conda && \
    rm /tmp/miniconda.sh && \
    echo "export PATH=/home/conda/bin:$PATH" > /etc/profile.d/conda.sh
ENV PATH /home/conda/bin:$PATH

RUN conda init

# Copy environment.yml (if found) to a temp location so we update the environment. Also
# copy "noop.txt" so the COPY instruction does not fail if no environment.yml exists.
COPY ml/environment.yml ml/noop.txt /tmp/conda-tmp/
RUN if [ -f "/tmp/conda-tmp/environment.yml" ]; then umask 0002 && /home/conda/bin/conda env update -n base -f /tmp/conda-tmp/environment.yml; fi \
    && sudo rm -rf /tmp/conda-tmp

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Cleanup
RUN apt autoremove -y \
    && apt clean -y \
    && rm -rf /var/lib/apt/lists/*

# Generate locale for agnoster
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && /usr/sbin/locale-gen

# the user we're applying this too (otherwise it most likely install for root)
USER $USERNAME

ENV TERM xterm

# Set the default shell to bash rather than sh
ENV SHELL /bin/zsh

# Set home dir
ENV HOME /home/$USERNAME

# run the installation script
RUN sh -c "$(wget -O- https://install.ohmyz.sh/)"

# install powerlevel10k
# RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# RUN cd $HOME && curl -fsSLO https://raw.gitmirror.com/romkatv/dotfiles-public/master/.purepower

# zsh configuration
ADD cpp/.zshrc $HOME

# https://brew.sh/
RUN /bin/bash -c "$(curl -fsSL  https://ghfast.top/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
