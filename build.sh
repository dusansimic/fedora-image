#!/bin/bash

set -ouex pipefail

export VARIANT="main"
export RELEASE="$(rpm -E %fedora)"
export KERNEL="$(rpm -q kernel | sed 's~kernel-~~')"

/ctx/scripts/01_install_repos.sh

/ctx/scripts/02_install_kernels.sh

/ctx/scripts/03_install_akmods.sh

/ctx/scripts/04_install_packages.sh

/ctx/scripts/05_enable_services.sh

/ctx/scripts/06_configure_signing.sh
