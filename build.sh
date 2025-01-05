#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### RPMFusion

rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

### Remove packages

rpm-ostree override remove \
  gnome-tour

### Install packages

rpm-ostree install \
  /tmp/akmods-rpms/kmod-VirtualBox*.rpm

rpm-ostree install \
  eza \
  fish \
  gh \
  git-lfs \
  gitflow \
  mosh \
  conda \
  ansible

rpm-ostree install \
  containerd.io \
  docker-buildx-plugin \
  docker-ce \
  docker-ce-cli \
  docker-compose-plugin

rpm-ostree install \
  fira-code-fonts \
  gnome-backgrounds-extras \
  gnome-console \
  NetworkManager-sstp \
  sushi \
  tlp

rpm-ostree install \
  VirtualBox \
  VirtualBox-extpack

rpm-ostree install \
  gnome-commander

# rpm-ostree install \
#   terraform \
#   packer \
#   vagrant

### Exchange

rpm-ostree override \
  remove nano-default-editor \
  --install vim-default-editor

### Enable daemons

systemctl enable docker.service
