#!/bin/bash

set -ouex pipefail

# Find latest version

VAGRANT_VERSION=$(curl -s https://releases.hashicorp.com/vagrant | htmlq --text 'html body ul li a' | sed 's~vagrant_~~' | sort -V | tail -n1)
RELEASE_DIR_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/"
VAGRANT_RELEASE=$(curl -s https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/ | htmlq --text 'html body ul li a' | grep 'x86_64.rpm' | sed 's~vagrant-~~;s~.x86.*~~' | sort -V | tail -n1)
ZIP_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_amd64.zip"

# Unzip into a temporary directory
TMP_DIR=$(mktemp -d)
curl -sL "${ZIP_URL}" -o "${TMP_DIR}/vagrant.zip"
unzip -q "${TMP_DIR}/vagrant.zip" -d "${TMP_DIR}"

# Move the vagrant binary to /usr/bin
install -Dm755 "${TMP_DIR}/vagrant" -t /usr/bin

# Cleanup temporary directory
rm -rf "${TMP_DIR}"
