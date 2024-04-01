#!/bin/bash

set -e

if [ -z $1 ]; then
    echo "Usage: $0 <llvm-repo>"
    exit 1
fi

# source "$(hatch env find)/bin/activate"

cmake -S llvm -B $1 -GNinja                                                                                  \
    -C ./clang/cmake/caches/3-stage-base.cmake                                                               \
    -D CLANG_ENABLE_BOOTSTRAP=On                                                                             \
    -D CLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE;LIBCXX_ABI_VERSION;LIBCXX_INSTALL_MODULES;LIBCXXABI_ENABLE_ASSERTIONS;LIBCXXABI_ENABLE_FORGIVING_DYNAMIC_CAST;LIBCXXABI_HERMETIC_STATIC_LIBRARY;LIBCXXABI_USE_LLVM_UNWINDER;DEFAULT_SYSROOT;FFI_INCLUDE_DIR;FFI_LIBRARY_DIR;LIBCXX_HERMETIC_STATIC_LIBRARY;CMAKE_POSITION_INDEPENDENT_CODE;LLVM_BUILD_EXTERNAL_COMPILER_RT;LIBCXX_USE_COMPILER_RT;LIBCXX_CXX_ABI;LIBCXX_ENABLE_VENDOR_AVAILABILITY_ANNOTATIONS;LIBCXX_ENABLE_SHARED;LIBCXX_ENABLE_STATIC;LLVM_ENABLE_LTO;LLVM_INCLUDE_TESTS;LLVM_ENABLE_Z3_SOLVER;LIBCXX_INSTALL_MODULES;LIBCXX_PSTL_CPU_BACKEND;LLVM_INCLUDE_DOCS;LLVM_PARALLEL_COMPILE_JOBS;LLVM_PARALLEL_LINK_JOBS" \
    -D CMAKE_BUILD_TYPE=Release                                                                              \
    -D CMAKE_INSTALL_PREFIX=$HOME/.llvm                                                                      \
    -D CMAKE_POSITION_INDEPENDENT_CODE=OFF                                                                   \
    -D CMAKE_VERBOSE_MAKEFILE=1                                                                              \
    -D DEFAULT_SYSROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/                                \
    -D FFI_INCLUDE_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/usr/include/ffi                 \
    -D FFI_LIBRARY_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/usr/lib                         \
    -D LIBCXXABI_ENABLE_ASSERTIONS=OFF                                                                       \
    -D LIBCXXABI_ENABLE_FORGIVING_DYNAMIC_CAST=ON                                                            \
    -D LIBCXXABI_HERMETIC_STATIC_LIBRARY=ON                                                                  \
    -D LIBCXXABI_USE_LLVM_UNWINDER=OFF                                                                       \
    -D LIBCXX_ABI_VERSION=1                                                                                  \
    -D LIBCXX_CXX_ABI="libcxxabi"                                                                            \
    -D LIBCXX_ENABLE_SHARED=ON                                                                               \
    -D LIBCXX_ENABLE_STATIC=ON                                                                               \
    -D LIBCXX_ENABLE_VENDOR_AVAILABILITY_ANNOTATIONS=ON                                                      \
    -D LIBCXX_HERMETIC_STATIC_LIBRARY=ON                                                                     \
    -D LIBCXX_INSTALL_MODULES=ON                                                                             \
    -D LIBCXX_PSTL_CPU_BACKEND="libdispatch"                                                                 \
    -D LIBCXX_USE_COMPILER_RT=ON                                                                             \
    -D LLVM_BUILD_EXTERNAL_COMPILER_RT=ON                                                                    \
    -D LLVM_ENABLE_LTO=Thin                                                                                  \
    -D LLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;mlir;polly"                                    \
    -D LLVM_ENABLE_RUNTIMES="libcxx;libunwind;libcxxabi;openmp;pstl;compiler-rt"                             \
    -D LLVM_ENABLE_Z3_SOLVER=ON                                                                              \
    -D LLVM_INCLUDE_DOCS=OFF                                                                                 \
    -D LLVM_INCLUDE_TESTS=OFF                                                                                \
    -D LLVM_PARALLEL_COMPILE_JOBS=5                                                                          \
    -D LLVM_PARALLEL_LINK_JOBS=3                                                                             \
    -D LLVM_POLLY_LINK_INTO_TOOLS=ON                                                                         \
    -Wno-dev

cmake --build $1 --target stage2
