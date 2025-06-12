#!/bin/bash

set -ouex pipefail

/ctx/packages.sh

/ctx/github_rust_tgz_install.sh astral-sh/uv
/ctx/github_rust_tgz_install.sh astral-sh/ruff
