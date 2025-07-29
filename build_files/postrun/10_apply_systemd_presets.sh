#!/bin/bash

set -ouex pipefail

# Apply systemd presets

systemctl preset-all
