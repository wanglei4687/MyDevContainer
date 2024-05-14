FROM debian:latest

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV TZ=Asia/Shanghai \
        DEBIAN_FRONTEND=noninteractive

RUN groupadd --gid $USER_GID $USERNAME \
        && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME 

RUN apt update

RUN apt install -y sudo wget curl software-properties-common \
        git vim fonts-powerline zsh gnupg2  ca-certificates \
        apt-transport-https pigz iptables  dirmngr jq \
        python3-minimal python3-pip libffi-dev python3-venv \
        build-essential libssl-dev \
        locales \
        # set up locale
        && locale-gen en_US.UTF-8

# default env set to node20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - 
RUN apt install -y nodejs

# Set NVM
RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.12.0
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
   && nvm install $NODE_VERSION \
   && nvm alias default $NODE_VERSION \
   && nvm use default
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
        && chmod 0440 /etc/sudoers.d/$USERNAME

# Clean up
RUN apt autoremove -y \
        && apt clean -y \
        && rm -rf /var/lib/apt/lists/* 

# generate locale for agnoster
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && /usr/sbin/locale-gen

RUN npm install -g aws-cdk yarn

# the user we're applying this too (otherwise it most likely install for root)
USER $USERNAME

ENV TERM xterm

# Set the default shell to bash rather than sh
ENV SHELL /bin/zsh

# set home
ENV HOME /home/$USERNAME


# Set the default shell to bash rather than sh
ENV SHELL /bin/zsh

# run the installation script
RUN sh -c "$(wget -O- https://install.ohmyz.sh/)"

# install powerlevel10k
# RUN git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# RUN cd $HOME && curl -fsSLO https://raw.gitmirror.com/romkatv/dotfiles-public/master/.purepower

# zsh configuration
ADD node/.zshrc $HOME
