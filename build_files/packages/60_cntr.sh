#!/bin/bash

set -ouex pipefail

API_URL="https://api.github.com/repos/Mic92/cntr/releases/latest"
BIN_URL=$(curl --fail --retry 5 --retry-delay 5 --retry-all-errors -sL "${API_URL}" | jq -r '.assets | sort_by(.created_at) | reverse | .[] | select(.name|test("linux")) | .browser_download_url')

# Download binary
curl --fail --retry 5 --retry-delay 5 --retry-all-errors -L -o /tmp/cntr "${BIN_URL}"

# Install binary
install -Dm755 /tmp/cntr -t /usr/bin

# Cleanup
rm -rf /tmp/cntr
