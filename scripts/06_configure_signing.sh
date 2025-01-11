#!/bin/bash

set -ouex pipefail

mkdir -p /etc/containers
mkdir -p /etc/pki/containers
mkdir -p /etc/containers/registries.d

if [ -f /usr/etc/containers/policy.json ]
then
  cp /usr/etc/containers/policy.json /etc/containers/policy.json
fi

cat <<<"$(jq '.transports.docker |=. + {
   "ghcr.io/dusansimic/fedora-image": [
    {
        "type": "sigstoreSigned",
        "keyPath": "/etc/pki/containers/dusansimic_fedora-image.pub",
        "signedIdentity": {
            "type": "matchRepository"
        }
    }
]}' <"/etc/containers/policy.json")" >"/tmp/policy.json"
cp /tmp/policy.json /etc/containers/policy.json
cp /ctx/cosign.pub /etc/pki/containers/dusansimic_fedora-image.pub
cp /ctx/signing/dusansimic_fedora-image.yaml /etc/containers/registries.d/dusansimic_fedora-image.yaml

mkdir -p /usr/etc/containers/
cp /etc/containers/policy.json /usr/etc/containers/policy.json
