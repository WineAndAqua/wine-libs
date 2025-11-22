#!/bin/sh -e

PKGNAME=SPIRV-LLVM-Translator

export PKG_CONFIG_PATH=$(pwd)/llvm-workspace/spirv-tools-arm64/lib/pkgconfig:$PKG_CONFIG_PATH

mkdir -p llvm-workspace/build-spirv-llvm-translator-arm64
cmake -B llvm-workspace/build-spirv-llvm-translator-arm64 -S llvm-workspace/${PKGNAME} \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR="$(pwd)/llvm-workspace/llvm-arm64/lib/cmake/llvm" \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DLLVM_HOST_TRIPLE=x86_64-apple-darwin \
    -DLLVM_TARGETS_TO_BUILD="AArch64" \
    -DBUILD_SHARED_LIBS=ON \
    -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-llvm-translator-arm64" \
    -G Ninja

pushd llvm-workspace/build-spirv-llvm-translator-arm64
ninja
ninja install
popd
