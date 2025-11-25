#!/bin/sh -e

PKGNAME=mesa

REV=8f2eeee7bacd40d9107eeaec609c8add44f2a077

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone --branch main https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
