#!/bin/sh -e

PKGNAME=mesa

REV=c4039495967db0bff1ffaf2c955bc8586ce9c269

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone --branch main https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
