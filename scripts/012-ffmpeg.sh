#!/bin/sh -e

WINE_LIBS=${WINE_LIBS:=$(PWD)/../target}

PATH=${WINE_LIBS}/bin:${PATH}

VER=8.0
PKGNAME=ffmpeg

if [ ! -f ${PKGNAME}-${VER}.tar.xz ]; then wget --continue https://ffmpeg.org/releases/${PKGNAME}-${VER}.tar.xz; fi

rm -Rf ${PKGNAME}-${VER} && tar xf ${PKGNAME}-${VER}.tar.xz && cd ${PKGNAME}-${VER}

if [ -f ../../patches/${PKGNAME}.patch ]; then cat ../../patches/${PKGNAME}.patch | patch -p1; fi

if [ "$TARGET_X86" = "yes" ]; then
    export CC="clang -arch x86_64"
    export CXX="clang++ -arch x86_64"
    TARGET_ARCH="x86"
else
    TARGET_ARCH="aarch64"
fi
CFLAGS="-I${WINE_LIBS}/include" \
LDFLAGS="-L${WINE_LIBS}/lib" \
./configure \
--prefix="$WINE_LIBS" \
--pkgconfigdir="${WINE_LIBS}/lib/pkgconfig" \
--pkg-config=${WINE_LIBS}/bin/pkg-config \
--cc="${CC}" \
--cxx="${CXX}" \
--arch=$TARGET_ARCH \
--enable-shared \
--disable-static \
--enable-pthreads \
--enable-gnutls \
--enable-videotoolbox \
--enable-audiotoolbox \
--disable-doc \
--disable-avx2 \
--disable-libjack \
--disable-libopencore-amrnb \
--disable-libopencore-amrwb \
--disable-libplacebo \
--disable-libvmaf \
--disable-libxcb \
--disable-libxcb-shm \
--disable-libxcb-xfixes \
--disable-metal \
--disable-opencl \
--disable-sdl2 \
--disable-securetransport \
--disable-xlib \
--disable-lcms2 \
--disable-libass \
--disable-libbluray \
--disable-libdav1d \
--disable-libfreetype \
--disable-libfribidi \
--disable-libmodplug \
--disable-libmp3lame \
--disable-libopenjpeg \
--disable-libopus \
--disable-librsvg \
--disable-libsoxr \
--disable-libspeex \
--disable-libtheora \
--disable-libvorbis \
--disable-libvpx \
--disable-libwebp \
--disable-libzimg \
--disable-libzvbi \
--disable-lzma \
--disable-swscale \
--disable-zlib

PROCS="$(sysctl -n hw.ncpu 2>/dev/null)"
${MAKE:-make} -j $PROCS && ${MAKE:-make} install-libs install-headers
