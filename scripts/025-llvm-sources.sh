#!/bin/sh -e

VER=21.1.8
PKGNAME=llvm

if [ ! -d llvm-workspace/llvm-sources ]; then
    mkdir -p llvm-workspace
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz -C llvm-workspace
    mv llvm-workspace/llvm-project-llvmorg-${VER} llvm-workspace/${PKGNAME}-sources
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d llvm-workspace/${PKGNAME}-sources; fi
fi
