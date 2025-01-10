#!/bin/bash

set -ouex pipefail

skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods-extra:${VARIANT}-${RELEASE}-${KERNEL} dir:/tmp/akmods-extra
AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods-extra/manifest.json | cut -d : -f 2)
tar -xzvf /tmp/akmods-extra/${AKMODS_TARGZ} -C /
mv /tmp/akmods-rpms/* /tmp/akmods-extra/

rpm-ostree install \
  /tmp/akmods-extra/*VirtualBox*.rpm
