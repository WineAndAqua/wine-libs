#!/bin/sh -e

WINE_LIBS=${WINE_LIBS:=$(PWD)/../target}

PATH=${WINE_LIBS}/bin:${PATH}

VER=20240724
PKGNAME=libinotify

if [ ! -f ${PKGNAME}-${VER}.tar.gz ]; then wget --continue https://github.com/libinotify-kqueue/libinotify-kqueue/releases/download/${VER}/${PKGNAME}-${VER}.tar.gz; fi

rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.gz && cd ${PKGNAME}-${VER}

if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1; fi

CC="clang -arch x86_64" \
CXX="clang++ -arch x86_64" \
CFLAGS="-I${WINE_LIBS}/include" \
LDFLAGS="-L${WINE_LIBS}/lib" \
./configure \
--prefix="$WINE_LIBS" \
--enable-shared \
--disable-static \

PROCS="$(sysctl -n hw.ncpu 2>/dev/null)"
${MAKE:-make} -j $PROCS && ${MAKE:-make} install
