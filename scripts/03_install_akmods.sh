#!/bin/bash

set -ouex pipefail

# TODO: Skip VBox install for now

# # fetch kmods rpms

# skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods-extra:${VARIANT}-${RELEASE}-${KERNEL} dir:/tmp/akmods-extra
# AKMODS_TARGZ=$(jq -r '.layers[].digest' < /tmp/akmods-extra/manifest.json | cut -d : -f 2)
# tar -xzvf /tmp/akmods-extra/${AKMODS_TARGZ} -C /tmp/

# # install kmods

# dnf5 -y install \
#   /tmp/rpms/kmods/*VirtualBox*.rpm
