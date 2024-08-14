#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/../..
cd $PROJECT_ROOT_DIR

x86_64-w64-mingw32-g++ \
    -o build/windows-x86_64-debug/sfml-test.exe \
    src/main.cpp src/platform/windows/WindowsImpl.cpp \
    -Wall --std=c++17 \
    -I/SFML/include \
    -L/SFML/build/lib \
    -lsfml-graphics-d -lsfml-window-d -lsfml-system-d -lsfml-audio-d
