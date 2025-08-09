#!/bin/bash

set -ouex pipefail

# Install VirtualBox kernel modules
dnf5 -y install \
  akmod-VirtualBox

akmods --force --kernels $KERNEL --kmod VirtualBox
