#!/bin/bash

set -ouex pipefail

### Install additional packages

dnf5 -y install --allowerasing \
  eza \
  jq \
  yq \
  fish \
  gh \
  git-lfs \
  gitflow \
  mosh \
  conda \
  uv \
  ruff \
  ansible \
  containerd.io \
  docker-ce \
  docker-ce-cli \
  docker-buildx-plugin \
  docker-compose-plugin \
  fira-code-fonts \
  gnome-console \
  gnome-backgrounds-extras \
  NetworkManager-sstp \
  sushi \
  tlp \
  VirtualBox \
  VirtualBox-extpack \
  vim-default-editor \
  qemu-char-spice \
  qemu-device-display-virtio-gpu \
  qemu-device-display-virtio-vga \
  qemu-device-usb-redirect \
  qemu-img \
  qemu-system-x86-core \
  qemu-user-binfmt \
  qemu-user-static \
  qemu \
  virt-manager \
  virt-viewer \
  virt-v2v \
  keyd \
  fira-code-fonts \
  awscli2 \
  s3cmd

# Remove packaages
dnf5 -y remove \
  gnome-tour \
  nano-default-editor \
  gnome-terminal
