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

log_info "Install console tools"

rpm-ostree install \
  eza \
  fish \
  gh \
  git-lfs \
  gitflow \
  mosh \
  conda \
  ansible


log_info "Install docker"

rpm-ostree install \
  containerd.io \
  docker-buildx-plugin \
  docker-ce \
  docker-ce-cli \
  docker-compose-plugin


log_info "Install misc. packages"

rpm-ostree install \
  fira-code-fonts \
  gnome-backgrounds-extras \
  gnome-console \
  NetworkManager-sstp \
  sushi \
  tlp


log_info "Install VirtualBox"

rpm-ostree install \
  VirtualBox \
  VirtualBox-extpack


log_info "Install additional file managers"

rpm-ostree install \
  gnome-commander \
  krusader

### Exchange

log_info "Exchange packages"

rpm-ostree override \
  remove nano-default-editor \
  --install vim-default-editor


### Enable daemons

log_info "Enable daemons"

systemctl enable docker.service
