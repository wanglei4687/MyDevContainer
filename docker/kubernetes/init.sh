#!/bin/bash

set -e

function install_golang() {
  sudo wget https://go.dev/dl/go$1.linux-amd64.tar.gz 
  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$1.linux-amd64.tar.gz
  export PATH=$PATH:/usr/local/go/bin
}


## Using proxy https://ghgo.xyz/ 
function install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://ghp.ci/https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function clean() {
  sudo rm -rf go$1.linux-amd64.tar.gz
}

install_homebrew
install_golang $1
clean $1