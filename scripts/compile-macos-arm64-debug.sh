#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

oa64-clang++ --std=c++17 \
    -I/SFML/include \
    -L/SFML/build/lib \
    -lsfml-graphics-d -lsfml-window-d -lsfml-system-d \
    -Wl,-rpath,'@executable_path/../lib' \
    -o build/macos-arm64-debug/bin/sfml-test \
    src/main.cpp
