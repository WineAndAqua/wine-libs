#!/bin/sh -e

PKGNAME=mesa

REV=393bf0d1467c4a7e208fd0d36b05b99438926079

if [ ! -d mesa-workspace/${PKGNAME}-sources ]; then
    mkdir -p mesa-workspace/${PKGNAME}-sources
    pushd mesa-workspace/${PKGNAME}-sources
    git init
    git remote add origin https://gitlab.freedesktop.org/mesa/mesa.git
    git fetch --depth 1 origin ${REV}
    git checkout FETCH_HEAD
    popd

    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d mesa-workspace/${PKGNAME}-sources; fi
fi
