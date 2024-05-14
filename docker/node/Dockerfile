FROM debian:latest

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG NODE_VERSION=20

ENV TZ=Asia/Shanghai \
        DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN groupadd --gid $USER_GID $USERNAME \
        && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
        && apt-get install -y sudo wget curl \
        && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
        && chmod 0440 /etc/sudoers.d/$USERNAME

# default env set to node20
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -

RUN apt install nodejs -y

RUN apt install -y software-properties-common aptitude \
        git vim fonts-powerline zsh gnupg2 ca-certificates \
        locales \
        # set up locale
        && locale-gen en_US.UTF-8

# default env set to node20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - 
RUN aptitude install npm -y

# Clean up
RUN apt autoremove -y \
        && apt clean -y \
        && rm -rf /var/lib/apt/lists/* 

# generate locale for agnoster
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && /usr/sbin/locale-gen

RUN npm install -g aws-cdk yarn

RUN node -v
RUN yarn -v
RUN cdk --version

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
