#!/bin/bash

set -ouex pipefail

# remove existing kernels

for pkg in kernel kernel-core kernel-modules kernel-modules-core kernel-modules-extra
do
  rpm --erase $pkg --nodeps
done

# fetch kernel rpms

skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods:${VARIANT}-${RELEASE} dir:/tmp/kernel-rpms
KERNEL_TARGZ=$(jq -r '.layers[].digest' </tmp/kernel-rpms/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/kernel-rpms/${KERNEL_TARGZ} -C /tmp/

# install kernels

dnf5 -y install \
  /tmp/kernel-rpms/kernel-[0-9]*.rpm \
  /tmp/kernel-rpms/kernel-core-*.rpm \
  /tmp/kernel-rpms/kernel-modules-*.rpm

dnf5 -y install \
  /tmp/kernel-rpms/kernel-devel-*.rpm

dnf5 versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra

