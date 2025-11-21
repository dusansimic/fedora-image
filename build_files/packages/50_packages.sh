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
  keyd \
  fira-code-fonts \
  awscli2 \
  s3cmd \
  opentofu \
  java-latest-openjdk \
  java-21-openjdk \
  python3-wxpython4 \
  pipx \
  wireshark

# Remove packages
dnf5 -y remove \
  gnome-tour \
  nano-default-editor \
  gnome-terminal
