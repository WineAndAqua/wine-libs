#!/bin/sh -e

VER=1.4.328.1

PKGNAME=SPIRV-Headers

if [ ! -d llvm-workspace/${PKGNAME}-vulkan-sdk-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/SPIRV-Headers/archive/refs/tags/vulkan-sdk-${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf llvm-workspace/${PKGNAME}-vulkan-sdk-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz -C llvm-workspace
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d llvm-workspace/${PKGNAME}-vulkan-sdk-${VER}; fi
fi

mkdir -p llvm-workspace/build-spirv-headers
cmake -B llvm-workspace/build-spirv-headers -S llvm-workspace/${PKGNAME}-vulkan-sdk-${VER} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-headers" \
    -G Ninja

pushd llvm-workspace/build-spirv-headers
ninja
ninja install
popd
