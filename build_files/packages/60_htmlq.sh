#!/bin/bash

set -ouex pipefail

API_URL="https://api.github.com/repos/mgdm/htmlq/releases/latest"
TAR_URL=$(curl --fail --retry 5 --retry-delay 5 --retry-all-errors -sL "${API_URL}" | jq -r --arg arch_filter 'x86_64' '.assets | sort_by(.created_at) | reverse | .[] | select(.name|test("linux")) | .browser_download_url')

# Download archive
curl --fail --retry 5 --retry-delay 5 --retry-all-errors -L -o /tmp/htmlq.tar.gz "${TAR_URL}"

# Extract and install
mkdir -p /tmp/htmlq
tar -xzf /tmp/htmlq.tar.gz -C /tmp/htmlq
chmod +x /tmp/htmlq/htmlq
install -Dm755 /tmp/htmlq/htmlq -t /usr/local/bin

# Cleanup
rm -rf /tmp/htmlq /tmp/htmlq.tar.gz
