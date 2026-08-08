#!/bin/sh -e

VER=1.4.357

PKGNAME=Vulkan-Loader

WINE_LIBS=${WINE_LIBS:=$(pwd)/../target}

if [ ! -d ${PKGNAME}-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/${PKGNAME}/archive/refs/tags/v${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d ${PKGNAME}-${VER}; fi
fi

cd ${PKGNAME}-${VER}

if [ "$TARGET_X86" = "yes" ]; then
    TARGET_ARCH="x86_64"
else
    TARGET_ARCH="arm64"
fi

cmake -B build -S . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$WINE_LIBS" \
    -DCMAKE_OSX_ARCHITECTURES=$TARGET_ARCH

cmake --build build --target install
