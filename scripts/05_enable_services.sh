#!/bin/bash

set -ouex pipefail

# enable services
systemctl enable docker.service

# disable services
systemctl disable chronyd.service
