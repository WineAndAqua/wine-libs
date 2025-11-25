#!/bin/sh -e

VER=16.1.0

PKGNAME=glslang

WINE_LIBS=${WINE_LIBS:=$(pwd)/../target}

TOP=$(pwd)

if [ ! -d ${PKGNAME}-${VER} ]; then
    if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/KhronosGroup/${PKGNAME}/archive/refs/tags/${VER}.tar.gz -O ${PKGNAME}-${VER}.tar.gz; fi
    rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz
    if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1 -d ${PKGNAME}-${VER}; fi
fi

cd ${PKGNAME}-${VER}

cmake -B build -S . \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES=x86_64 \
    -DCMAKE_INSTALL_PREFIX="$WINE_LIBS" \
    -DCMAKE_PREFIX_PATH="${TOP}/llvm-workspace/spirv-tools-x86_64" \
    -DCMAKE_SKIP_RPATH=ON \
    -DBUILD_EXTERNAL=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DENABLE_GLSLANG_BINARIES=ON \
    -DALLOW_EXTERNAL_SPIRV_TOOLS=ON \
    -DGLSLANG_TESTS=OFF

cmake --build build --target install

install_name_tool -add_rpath ${WINE_LIBS}/lib ${WINE_LIBS}/bin/glslang
