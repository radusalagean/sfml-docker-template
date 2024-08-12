#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

oa64-clang++ --std=c++17 \
    -I/SFML/include \
    src/main.cpp src/platform/unix/macos/MacOSImpl.cpp \
    -L/SFML/build/lib \
    -lsfml-graphics-d -lsfml-window-d -lsfml-system-d -lsfml-audio-d \
    -Wl,-rpath,'@executable_path/../lib' \
    -o build/macos-arm64-debug/bin/sfml-test
