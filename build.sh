#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### RPMFusion

rpm-ostree install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm


rpm-ostree install \
  /tmp/akmods-rpms/kmod-VirtualBox*.rpm

/tmp/packages.sh

# rpm-ostree install \
#   terraform \
#   packer \
#   vagrant

### Enable daemons

systemctl enable docker.service
