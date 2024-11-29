#!/bin/bash

set -e

function install_golang() {
    sudo wget https://go.dev/dl/go1.23.3.linux-amd64.tar.gz 
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.3.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
}

function clean() {
    sudo rm -rf go1.23.3.linux-amd64.tar.gz
}

install_golang
clean