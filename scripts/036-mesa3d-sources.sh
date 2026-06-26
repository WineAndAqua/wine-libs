#!/bin/sh -e

PKGNAME=mesa

REV=0151fedf47288088b99057db82ff9df65f4d8d93

if [ ! -d mesa-workspace/${PKGNAME} ]; then
    git clone --branch main https://gitlab.freedesktop.org/mesa/mesa.git mesa-workspace/${PKGNAME} && cd mesa-workspace/${PKGNAME} && git checkout --force $REV && cd ../..
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}; fi
fi
