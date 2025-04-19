#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

cp /ctx/repos/* /etc/yum.repos.d/

dnf5 -y install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm \
  terra-release
