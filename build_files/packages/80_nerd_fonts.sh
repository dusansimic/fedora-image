#!/bin/bash

set -ouex pipefail

## Helper functions

download_and_unpack_font() {
    fontname=$1
    fontversion=$2
    curl -L -o /tmp/$fontname.tar.xz https://github.com/ryanoasis/nerd-fonts/releases/download/v$fontversion/$fontname.tar.xz
    mkdir /tmp/$fontname
    tar -xaf /tmp/$fontname.tar.xz --strip-components=1 -C /tmp/$fontname
    rm /tmp/$fontname.tar.xz
    mkdir /usr/share/fonts/${fontname}NerdFont
    mv /tmp/$fontname/*.ttf /usr/share/fonts/${fontname}NerdFont
    rm -rf /tmp/$fontname
}

## Variables

FONT_VERSION=3.4.0

## Download and install fonts

mkdir /usr/local/share/fonts
download_and_unpack_font "CascadiaCode" $FONT_VERSION
download_and_unpack_font "FiraCode" $FONT_VERSION
download_and_unpack_font "AdwaitaMono" $FONT_VERSION
