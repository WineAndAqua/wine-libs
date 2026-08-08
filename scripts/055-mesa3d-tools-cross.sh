#!/bin/sh -e

if [ "$TARGET_X86" != "yes" ]; then
    exit 0
fi

TOP=$(pwd)

PKGNAME=mesa

export LLVM_CONFIG=${TOP}/llvm-workspace/llvm-arm64/bin/llvm-config

export PKG_CONFIG_PATH=${TOP}/llvm-workspace/spirv-llvm-translator-arm64/lib/pkgconfig:${TOP}/llvm-workspace/spirv-tools-arm64/lib/pkgconfig:${TOP}/llvm-workspace/llvm-libclc/share/pkgconfig

meson setup mesa-workspace/build-${PKGNAME}-tools-cross mesa-workspace/${PKGNAME}-sources \
  -Dprefix="${TOP}/mesa-workspace/mesa-tools-cross" \
  -Dllvm=enabled \
  -Dspirv-tools=enabled \
  -Dmesa-clc=enabled \
  -Dinstall-mesa-clc=true \
  -Dgallium-drivers= \
  -Dvulkan-drivers= \
  -Dplatforms= \
  -Dzstd=disabled \
  -Dglx=disabled \
  -Degl=disabled \
  -Dgles1=disabled \
  -Dgles2=disabled \
  -Dbuild-tests=false \
  -Dbuildtype=release

ninja -C mesa-workspace/build-${PKGNAME}-tools-cross
ninja -C mesa-workspace/build-${PKGNAME}-tools-cross install

install_name_tool -add_rpath ${TOP}/llvm-workspace/llvm-arm64/lib ${TOP}/mesa-workspace/mesa-tools-cross/bin/mesa_clc
install_name_tool -add_rpath ${TOP}/llvm-workspace/spirv-llvm-translator-arm64/lib ${TOP}/mesa-workspace/mesa-tools-cross/bin/mesa_clc
install_name_tool -add_rpath ${TOP}/llvm-workspace/llvm-arm64/lib ${TOP}/mesa-workspace/mesa-tools-cross/bin/vtn_bindgen2
