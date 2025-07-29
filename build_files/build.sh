#!/bin/bash

set -ouex pipefail

export VARIANT="main"
export RELEASE="$(rpm -E %fedora)"
export KERNEL="$(rpm -q kernel | sed 's~kernel-~~')"

# copy system files
rsync -rvK /ctx/sys_files/ /

# run all pre-run scripts
find /ctx/prerun -type f -name "*.sh" | sort | while read -r script
do
  echo "running: $script"
  bash $script
done

# install and configure packages
find /ctx/packages -type f -name "*.sh" | sort | while read -r script
do
  echo "running: $script"
  bash $script
done
