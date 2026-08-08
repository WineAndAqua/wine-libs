#!/bin/sh -e

WINE_LIBS=${WINE_LIBS:=$(PWD)/../target}

PATH=${WINE_LIBS}/bin:${PATH}

VER=3.5.2
PKGNAME=libffi

if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/libffi/libffi/releases/download/v${VER}/${PKGNAME}-${VER}.tar.gz; fi

rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz && cd ${PKGNAME}-${VER}

if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1; fi

if [ "$TARGET_X86" = "yes" ]; then
    export CC="clang -arch x86_64"
    TARGET_ARCH="x86_64-apple-darwin"
else
    TARGET_ARCH="aarch64-apple-darwin"
fi
ABI=64 \
./configure \
--prefix="$WINE_LIBS" \
--build=$TARGET_ARCH \
--enable-shared \
--disable-static

PROCS="$(sysctl -n hw.ncpu 2>/dev/null)"
${MAKE:-make} -j $PROCS


mkdir -p ${WINE_LIBS}/include
cp $TARGET_ARCH/include/*.h ${WINE_LIBS}/include
mkdir -p ${WINE_LIBS}/lib
cp -P $TARGET_ARCH/.libs/*.dylib ${WINE_LIBS}/lib
cp $TARGET_ARCH/libffi.pc ${WINE_LIBS}/lib/pkgconfig
