#!/bin/bash

set -ouex pipefail

function log_info() {
  echo "[INFO] $1"
}

RELEASE="$(rpm -E %fedora)"

### RPMFusion

log_info "Add RPMFusion free and non-free"
rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-41.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-41.noarch.rpm


### Remove packages

log_info "Remove packages"

rpm-ostree override remove \
  gnome-software \
  gnome-tour


### Install packages

log_info "Install packages"

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
  tlp \
  VirtualBox \
  VirtualBox-extpack

### Exchange

log_info "Exchange packages"

rpm-ostree override \
  remove nano-default-editor \
  --install vim-default-editor


### Enable daemons

log_info "Enable daemons"

systemctl enable docker.service
