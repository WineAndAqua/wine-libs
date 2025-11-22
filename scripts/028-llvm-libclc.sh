#!/bin/sh -e

mkdir -p $(pwd)/llvm-workspace/llvm-libclc/share/pkgconfig

echo "\
libexecdir=\n\
\n\
Name: libclc\n\
Description: Library requirements of the OpenCL C programming language\n\
Version: 0.2.0\n\
Libs:\n\
" >  $(pwd)/llvm-workspace/llvm-libclc/share/pkgconfig/libclc.pc
