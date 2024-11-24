#!/bin/bash

set -ouex pipefail

function log_info() {
  echo "[INFO] $1"
}

RELEASE="$(rpm -E %fedora)"


### Remove packages

log_info "Remove packages"

rpm-ostree override remove \
  gnome-software \
  gnome-tour


### Install packages

log_info "Install packages"

  # packer \
  # vagrant
rpm-ostree install \
  ansible \
  conda \
  containerd.io \
  docker-buildx-plugin \
  docker-ce \
  docker-ce-cli \
  docker-compose-plugin \
  eza \
  fira-code-fonts \
  fish \
  gh \
  git-lfs \
  gitflow \
  gnome-backgrounds-extras \
  gnome-console \
  mosh \
  neovim \
  NetworkManager-sstp \
  sushi \
  tlp

### Exchange

log_info "Exchange packages"

rpm-ostree override \
  remove nano-default-editor \
  --install vim-default-editor


### Enable daemons

log_info "Enable daemons"

systemctl enable docker.service
