#!/bin/sh -e

VER=21.1.7
PKGNAME=llvm

if [ ! -d llvm-workspace/llvm-sources ]; then
    mkdir -p llvm-workspace
    git clone --depth 1 --branch llvmorg-${VER} https://github.com/llvm/llvm-project.git llvm-workspace/llvm-sources
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d llvm-workspace/${PKGNAME}-sources; fi
fi
