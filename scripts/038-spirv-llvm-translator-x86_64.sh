#!/bin/sh -e

if [ "$TARGET_X86" != "yes" ]; then
    exit 0
fi

PKGNAME=SPIRV-LLVM-Translator

export PKG_CONFIG_PATH=$(pwd)/llvm-workspace/spirv-tools-x86_64/lib/pkgconfig:$PKG_CONFIG_PATH

mkdir -p llvm-workspace/build-spirv-llvm-translator-x86_64
cmake -B llvm-workspace/build-spirv-llvm-translator-x86_64 -S llvm-workspace/${PKGNAME}-sources \
    -DCMAKE_BUILD_TYPE=Release \
    -DLLVM_DIR="$(pwd)/llvm-workspace/llvm-x86_64/lib/cmake/llvm" \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    -DLLVM_HOST_TRIPLE=x86_64-apple-darwin \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DBUILD_SHARED_LIBS=ON \
    -DLLVM_EXTERNAL_SPIRV_HEADERS_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-llvm-translator-x86_64" \
    -G Ninja

pushd llvm-workspace/build-spirv-llvm-translator-x86_64
ninja
ninja install
popd
