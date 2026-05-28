#!/bin/sh -e

PKGNAME=mesa

REV=e5d9cdb62afffdb4156079544ff7af6cd502393f

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone --branch main https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
