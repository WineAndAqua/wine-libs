#!/bin/sh -e

VER=1.4.335

PKGNAME=Vulkan-Headers

WINE_LIBS=${WINE_LIBS:=$(pwd)/../target}

if [ ! -d ${PKGNAME}-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/${PKGNAME}/archive/refs/tags/v${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d ${PKGNAME}-${VER}; fi
fi

cd ${PKGNAME}-${VER}

cmake -B build -S . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$WINE_LIBS"

cmake --build build --target install
