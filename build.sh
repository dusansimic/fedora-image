#!/bin/bash

set -ouex pipefail

export VARIANT="main"
export RELEASE="$(rpm -E %fedora)"
export KERNEL="$(uname -r)"

/tmp/scripts/01_install_repos.sh

/tmp/scripts/02_install_kernels.sh

/tmp/scripts/03_install_akmods.sh

/tmp/scripts/04_install_packages.sh

/tmp/scripts/05_enable_services.sh
