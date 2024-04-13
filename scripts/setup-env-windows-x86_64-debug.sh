#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

mkdir -p build/windows-x86_64-debug
cp -r /SFML/build/lib/*.dll build/windows-x86_64-debug/
cd /usr/lib/gcc/x86_64-w64-mingw32/10-win32
cp libgcc_s_seh-1.dll libstdc++-6.dll /workspace/build/windows-x86_64-debug/
