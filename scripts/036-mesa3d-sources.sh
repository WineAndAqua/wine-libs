#!/bin/sh -e

PKGNAME=mesa

REV=3eef0c02453b59ed6380338fde8edd3063dd4227

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
