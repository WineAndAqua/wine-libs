#!/bin/sh -e

if [ "$TARGET_X86" == "yes" ]; then
    exit 0
fi

PKGNAME=SPIRV-Tools

mkdir -p llvm-workspace/build-spirv-tools-native
cmake -B llvm-workspace/build-spirv-tools-native -S llvm-workspace/${PKGNAME}-sources \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="arm64" \
    -DSPIRV-Headers_SOURCE_DIR="$(pwd)/llvm-workspace/spirv-headers" \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/spirv-tools-native" \
    -DSPIRV_WERROR=OFF \
    -DSPIRV_SKIP_TESTS=ON \
    -G Ninja

pushd llvm-workspace/build-spirv-tools-native
ninja
ninja install
popd
