#!/bin/sh -e

PKGNAME=SPIRV-Tools

mkdir -p llvm-workspace/build-spirv-tools-x86_64
cmake -B llvm-workspace/build-spirv-tools-x86_64 -S llvm-workspace/${PKGNAME} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    -DSPIRV-Headers_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-tools-x86_64" \
    -DSPIRV_WERROR=OFF \
    -DSPIRV_SKIP_TESTS=ON \
    -G Ninja

pushd llvm-workspace/build-spirv-tools-x86_64
ninja
ninja install
popd
