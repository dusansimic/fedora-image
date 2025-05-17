#!/bin/bash

# A script that installs tgz files built by rust from GitHub release pages.

# Arguments:
#   ORG_PROJ - organization and project name (part of the url)
#   RELTAG - release tag (either empty for latest or version for tag)

ORG_PROJ=${1}
RELTAG=${4}

if [ -z ${ORG_PROJ} ]
then
  echo "ORG_PROJ not defined"
  exit 1
fi

if [ -z ${RELTAG} ]
then
  RELTAG="latest"
else
  RELTAG="tags/${RELTAG}"
fi

set -ouex pipefail

API_JSON=$(mktemp /tmp/api-XXXXXXXX.json)
API="https://api.github.com/repos/${ORG_PROJ}/releases/${RELTAG}"

curl --fail --retry 5 --retry-delay 5 --retry-all-errors -sL ${API} -o ${API_JSON}
TGZ_URLS=($(cat ${API_JSON} |
  jq \
    -r \
    '.assets | sort_by(.created_at) | reverse | .[] | select(.name|test("x86_64")) | select(.name|test("linux-gnu.tar.gz$")) | .browser_download_url'
))

TGZ_FILE=$(mktemp /tmp/XXXXXXXX.tgz)

curl --fail --retry 5 --retry-delay 5 --retry-all-errors -sL ${TGZ_URLS} -o ${TGZ_FILE}

tar -xzf ${TGZ_FILE} --strip-components=1 -C /usr/bin
