#!/bin/sh -e

if [ ! -d llvm-workspace/llvm-sources ]; then
    mkdir -p llvm-workspace
    git clone --depth 1 --branch llvmorg-21.1.5 https://github.com/llvm/llvm-project.git llvm-workspace/llvm-sources
    if [ -f ../../patches/llvm.patch ]; then cat ../../patches/llvm.patch | patch -p1; fi
fi
