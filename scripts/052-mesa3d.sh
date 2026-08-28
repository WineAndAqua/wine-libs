#!/bin/sh -e

if [ "$TARGET_X86" == "yes" ]; then
    exit 0
fi

TOP=$(pwd)

PKGNAME=mesa

WINE_LIBS=${WINE_LIBS:=${TOP}/../target}

PATH=${WINE_LIBS}/bin:${PATH}

mkdir -p ${TOP}/${PKGNAME}-workspace/build-${PKGNAME}

export LLVM_CONFIG=${TOP}/llvm-workspace/llvm-native/bin/llvm-config

export PKG_CONFIG_PATH=${TOP}/llvm-workspace/spirv-llvm-translator-native/lib/pkgconfig:${TOP}/llvm-workspace/spirv-tools-native/lib/pkgconfig:${TOP}/llvm-workspace/llvm-libclc/share/pkgconfig

meson setup ${TOP}/mesa-workspace/build-${PKGNAME} ${TOP}/mesa-workspace/${PKGNAME}-sources \
  -Dprefix="$WINE_LIBS" \
  -Dgallium-drivers=zink \
  -Dvulkan-drivers=kosmickrisp \
  -Dplatforms=macos \
  -Dzstd=disabled \
  -Dglx=disabled \
  -Degl=disabled \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dbuild-tests=false \
  -Dbuildtype=release

ninja -C mesa-workspace/build-${PKGNAME}

ninja -C mesa-workspace/build-${PKGNAME} install
