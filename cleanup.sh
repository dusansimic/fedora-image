#!/bin/bash

set -eoux pipefail
shopt -s extglob

dnf5 clean all
rm -rf /tmp/* || true
