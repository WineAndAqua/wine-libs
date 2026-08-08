#!/bin/sh -e

if [ "$TARGET_X86" == "yes" ]; then
    exit 0
fi

PKGNAME=SPIRV-LLVM-Translator

export PKG_CONFIG_PATH=$(pwd)/llvm-workspace/spirv-tools-native/lib/pkgconfig:$PKG_CONFIG_PATH

mkdir -p llvm-workspace/build-spirv-llvm-translator-native
cmake -B llvm-workspace/build-spirv-llvm-translator-native -S llvm-workspace/${PKGNAME} \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR="$(pwd)/llvm-workspace/llvm-native/lib/cmake/llvm" \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DLLVM_HOST_TRIPLE=aarch64-apple-darwin \
    -DLLVM_TARGETS_TO_BUILD="AArch64" \
    -DBUILD_SHARED_LIBS=ON \
    -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-llvm-translator-native" \
    -G Ninja

pushd llvm-workspace/build-spirv-llvm-translator-native
ninja
ninja install
popd
