#!/bin/sh -e

mkdir -p llvm-workspace/build-cross
cmake -B llvm-workspace/build-cross -S llvm-workspace/llvm-sources/llvm \
    -DCMAKE_INSTALL_PREFIX="$(pwd)/llvm-workspace/llvm-cross" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_OSX_ARCHITECTURES="x86_64" \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_DEFAULT_TARGET_TRIPLE=x86_64-apple-darwin \
    -DLLVM_ENABLE_PROJECTS="clang;lld" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_ZSTD=Off \
    -DLLVM_ENABLE_LIBEDIT=OFF \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_INCLUDE_DOCS=OFF \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -G Ninja

pushd llvm-workspace/build-cross
ninja
ninja install
popd
