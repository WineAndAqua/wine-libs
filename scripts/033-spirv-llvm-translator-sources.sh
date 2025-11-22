#!/bin/sh -e

VER=21.1.2

PKGNAME=SPIRV-LLVM-Translator

if [ ! -d llvm-workspace/${PKGNAME}-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/SPIRV-LLVM-Translator/archive/refs/tags/v${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf llvm-workspace/${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz -C llvm-workspace
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d llvm-workspace/${PKGNAME}-${VER}; fi
    mv llvm-workspace/${PKGNAME}-${VER} llvm-workspace/${PKGNAME}
fi
