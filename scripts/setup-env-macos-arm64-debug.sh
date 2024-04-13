#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

mkdir -p build/macos-arm64-debug/bin
mkdir -p build/macos-arm64-debug/lib
mkdir -p build/macos-arm64-debug/Frameworks
cp -r /SFML/build/lib/*.dylib build/macos-arm64-debug/lib/
cp -r /SFML/extlibs/libs-osx/Frameworks/* build/macos-arm64-debug/Frameworks/
