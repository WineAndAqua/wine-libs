#!/bin/sh -e

PKGNAME=SPIRV-Tools

mkdir -p llvm-workspace/build-spirv-tools-arm64
cmake -B llvm-workspace/build-spirv-tools-arm64 -S llvm-workspace/${PKGNAME} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DSPIRV-Headers_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-tools-arm64" \
    -DSPIRV_WERROR=OFF \
    -DSPIRV_SKIP_TESTS=ON \
    -G Ninja

pushd llvm-workspace/build-spirv-tools-arm64
ninja
ninja install
popd
