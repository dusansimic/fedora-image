#!/bin/bash

set -ouex pipefail

# Install kernel-devel

skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/${VARIANT}-kernel:${RELEASE}-${KERNEL} dir:/tmp/kernel-rpms
KERNEL_TARGZ=$(jq -r '.layers[].digest' </tmp/kernel-rpms/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/kernel-rpms/${KERNEL_TARGZ} -C /
mv /tmp/rpms/* /tmp/kernel-rpms/

if [[ -z "$(grep kernel-devel <<<$(rpm -qa))" ]]
then
  rpm-ostree install /tmp/kernel-rpms/kernel-devel-*.rpm
fi

# Install kmods

skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods-extra:${VARIANT}-${RELEASE}-${KERNEL} dir:/tmp/akmods-extra
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods-extra/manifest.json | cut -d : -f 2)
tar -xzvf /tmp/akmods-extra/${AKMODS_TARGZ} -C /tmp
mv /tmp/rpms/kmods/* /tmp/akmods-extra/

rpm-ostree install \
  /tmp/akmods-extra/*VirtualBox*.rpm
