#!/bin/sh -e

WINE_LIBS=${WINE_LIBS:=$(PWD)/../target}

PATH=${WINE_LIBS}/bin:${PATH}

PKGNAME=moltenvk

REV=bf60f60d0805e9b3ab989cfc1b69f780f96fd123

if [ ! -d ${PKGNAME} ]; then
    git clone --depth 1 --branch main https://github.com/KhronosGroup/MoltenVK.git ${PKGNAME} && cd ${PKGNAME} && git checkout --force $REV && cd ..
    if [ -f ../patches/SPIRV-Cross.patch ]; then cp ../patches/SPIRV-Cross.patch ${PKGNAME}; fi
    if [ -f ../patches/${PKGNAME}.patch ]; then cat ../patches/${PKGNAME}.patch | patch -p1 -d ${PKGNAME}; fi
    cd ${PKGNAME} && ./fetchDependencies --macos && cd ..
fi

cd moltenvk

PROCS="$(sysctl -n hw.ncpu 2>/dev/null)"
${MAKE:-make} -j $PROCS clean
${MAKE:-make} -j $PROCS macos

mkdir -p ${WINE_LIBS}/lib
cp -p Package/Latest/MoltenVK/dynamic/dylib/macOS/libMoltenVK.dylib ${WINE_LIBS}/lib
