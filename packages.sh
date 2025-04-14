#!/usr/bin/bash

set -ouex pipefail

# build list of all packages requested for inclusion
readarray -t INCLUDED_PACKAGES < <(jq -r "[(.all.include | (select(.all != null).all)[])] \
                    | sort | unique[]" /ctx/packages.json)

if [[ "${#INCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    dnf5 -y install --allowerasing "${INCLUDED_PACKAGES[@]}"
fi

# build list of all packages requested for exclusion
readarray -t EXCLUDED_PACKAGES < <(jq -r "[(.all.exclude | (select(.all != null).all)[])] \
                    | sort | unique[]" /ctx/packages.json)

# remove any excluded packages which are still present on image
if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    dnf5 -y remove "${EXCLUDED_PACKAGES[@]}"
fi
