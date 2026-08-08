#!/bin/sh -e

WINE_LIBS=${WINE_LIBS:=$(PWD)/../target}

PATH=${WINE_LIBS}/bin:${PATH}

VER=1.27.2
PKGNAME=gst-plugins-good

if [ ! -f ${PKGNAME}-${VER}.tar.xz ]; then wget --continue https://gstreamer.freedesktop.org/src/${PKGNAME}/${PKGNAME}-${VER}.tar.xz; fi

rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.xz && cd ${PKGNAME}-${VER}

if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1; fi

mkdir -p build && cd build

if [ "$TARGET_X86" = "yes" ]; then
    TARGET_ARCH="x86_64"
    TARGET_CPU="x86_64"
else
    TARGET_ARCH="arm64"
    TARGET_CPU="aarch64"
fi

echo "\
[binaries]\n\
c = 'clang'\n\
cpp = 'clang++'\n\
objc = 'clang'\n\
objcpp = 'clang'\n\
strip = 'strip'\n\
pkg-config = '${WINE_LIBS}/bin/pkg-config'\n\
[host_machine]\n\
system = 'darwin'\n\
cpu_family = '$TARGET_CPU'\n\
cpu = '$TARGET_CPU'\n\
endian = 'little'\n\
" > cross.ini
CC="clang" \
CXX="clang++" \
LDFLAGS="-arch $TARGET_ARCH -L${WINE_LIBS}/lib" \
meson setup .. --cross-file=cross.ini \
-Dc_args="-arch $TARGET_ARCH -I${WINE_LIBS}/include -funroll-loops -fstrict-aliasing -fno-common" \
-Dcpp_args="-arch $TARGET_ARCH -I${WINE_LIBS}/include -funroll-loops -fstrict-aliasing -fno-common" \
-Dobjc_args="-arch $TARGET_ARCH" \
-Dc_link_args="-arch $TARGET_ARCH -L${WINE_LIBS}/lib" \
-Dcpp_link_args="-arch $TARGET_ARCH -L${WINE_LIBS}/lib" \
-Dprefix="$WINE_LIBS" \
-Dbuildtype=release \
-Ddoc=disabled \
-Dexamples=disabled \
-Dtests=disabled

meson compile
meson install

rm -rf ${WINE_LIBS}/share
