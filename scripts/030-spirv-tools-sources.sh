#!/bin/sh -e

VER=2025.4

PKGNAME=SPIRV-Tools

if [ ! -d llvm-workspace/${PKGNAME}-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/SPIRV-Tools/archive/refs/tags/v${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf llvm-workspace/${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz -C llvm-workspace
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d llvm-workspace/${PKGNAME}-${VER}; fi
    mv llvm-workspace/${PKGNAME}-${VER} llvm-workspace/${PKGNAME}
fi
