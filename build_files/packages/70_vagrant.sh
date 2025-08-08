#!/bin/bash

set -ouex pipefail

# Find latest version

VAGRANT_VERSION=$(curl -s https://releases.hashicorp.com/vagrant | htmlq --text 'html body ul li a' | sed 's~vagrant_~~' | sort -V | tail -n1)
RELEASE_DIR_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/"
VAGRANT_RELEASE=$(curl -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/ | htmlq --text 'html body ul li a' | grep 'x86_64.rpm' | sed 's~vagrant-~~;s~.x86.*~~' | sort -V | tail -n1)
RPM_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant-${VAGRANT_RELEASE}.x86_64.rpm"

# Install Vagrant
dnf5 -y install --allowerasing "${RPM_URL}"
