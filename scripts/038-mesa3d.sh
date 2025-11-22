#!/bin/sh -e

TOP=$(pwd)

PKGNAME=mesa


WINE_LIBS=${WINE_LIBS:=${TOP}/../target}

PATH=${WINE_LIBS}/bin:${TOP}/${PKGNAME}-workspace/${PKGNAME}-tools/bin:${PATH}

mkdir -p ${TOP}/${PKGNAME}-workspace/build-${PKGNAME}

echo "\
[binaries]\n\
c = 'clang'\n\
cpp = 'clang++'\n\
objc = 'clang'\n\
objcpp = 'clang++'\n\
ar = 'ar'\n\
strip = 'strip'\n\
pkg-config = '${WINE_LIBS}/bin/pkg-config'\n\
[built-in options]\n\
c_args = ['-target', 'x86_64-apple-darwin']\n\
c_link_args = ['-target', 'x86_64-apple-darwin']\n\
cpp_args = ['-target', 'x86_64-apple-darwin']\n\
cpp_link_args = ['-target', 'x86_64-apple-darwin']\n\
objc_args = ['-target', 'x86_64-apple-darwin']\n\
objc_link_args = ['-target', 'x86_64-apple-darwin']\n\
objcpp_args = ['-target', 'x86_64-apple-darwin']\n\
objcpp_link_args = ['-target', 'x86_64-apple-darwin']\n\
[host_machine]\n\
system = 'darwin'\n\
cpu_family = 'x86_64'\n\
cpu = 'x86_64'\n\
endian = 'little'\n\
" > ${PKGNAME}-workspace/build-${PKGNAME}/cross.ini
echo "\
[binaries]\n\
c = 'clang'\n\
cpp = 'clang++'\n\
objc = 'clang'\n\
objcpp = 'clang++'\n\
ar = 'ar'\n\
strip = 'strip'\n\
pkg-config = 'pkg-config'\n\
[host_machine]\n\
system = 'darwin'\n\
cpu_family = 'aarch64'\n\
cpu = 'arm64'\n\
endian = 'little'\n\
" > ${PKGNAME}-workspace/build-${PKGNAME}/native.ini


export LLVM_CONFIG=${TOP}/llvm-workspace/llvm-cross/bin/llvm-config

export PKG_CONFIG_PATH=${TOP}/llvm-workspace/spirv-llvm-translator-x86_64/lib/pkgconfig:${TOP}/llvm-workspace/spirv-tools-x86_64/lib/pkgconfig:${TOP}/llvm-workspace/llvm-libclc/share/pkgconfig


meson setup ${TOP}/mesa-workspace/build-${PKGNAME} ${TOP}/mesa-workspace/${PKGNAME} \
  --native-file=${TOP}/mesa-workspace/build-${PKGNAME}/native.ini \
  --cross-file=${TOP}/mesa-workspace/build-${PKGNAME}/cross.ini \
  -Dprefix="$WINE_LIBS" \
  -Dgallium-drivers= \
  -Dvulkan-drivers=kosmickrisp \
  -Dplatforms=macos \
  -Dmesa-clc=system \
  -Dzstd=disabled \
  -Dglx=disabled \
  -Degl=disabled \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dbuild-tests=false \
  -Dbuildtype=release

ninja -C mesa-workspace/build-mesa

ninja -C mesa-workspace/build-mesa install

#cp ${TOP}/mesa-workspace/build-mesa/src/kosmickrisp/vulkan/libvulkan_kosmickrisp.dylib ${WINE_LIBS}/lib
