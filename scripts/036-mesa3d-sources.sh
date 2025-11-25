#!/bin/sh -e

PKGNAME=mesa

REV=fee87679bf9435ae670006bc98dee660ec28d92c

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone --branch main https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
