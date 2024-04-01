#!/bin/bash

set -e

if [ -z $1 ]; then
    echo "Usage: $0 <llvm-repo>"
    exit 1
fi

source "$(hatch env find)/bin/activate"

cmake -S llvm -B $1 -GNinja                                                                                 \
    -D CMAKE_BUILD_TYPE=Release                                                                              \
    -D CMAKE_INSTALL_PREFIX=$HOME/.llvm                                                                      \
    -D DEFAULT_SYSROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/                                \
    -D FFI_INCLUDE_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/usr/include/ffi                 \
    -D FFI_LIBRARY_DIR=/Library/Developer/CommandLineTools/SDKs/MacOSX14.sdk/usr/lib                         \
    -D LLVM_BUILD_EXTERNAL_COMPILER_RT=ON                                                                    \
    -D LLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;lldb;mlir;polly"                                    \
    -D LLVM_ENABLE_RUNTIMES="libcxx;libunwind;libcxxabi;openmp;pstl;compiler-rt"                             \
    -D LLVM_ENABLE_LTO=Thin                                                                                  \
    -D LLVM_INCLUDE_DOCS=OFF                                                                                 \
    -D LLVM_INCLUDE_TESTS=OFF                                                                                \
    -D LLVM_POLLY_LINK_INTO_TOOLS=ON                                                                         \
    -D LLVM_TARGETS_TO_BUILD="AArch64"                                                                       \
    -D LLVM_ENABLE_Z3_SOLVER=ON                                                                              \
    -D CMAKE_POSITION_INDEPENDENT_CODE=OFF                                                                   \
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
    -Wno-dev

# cmake --build $1 --target install
