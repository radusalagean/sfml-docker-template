#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/../..
cd $PROJECT_ROOT_DIR

mkdir -p build/linux-x86_64-debug/bin
mkdir -p build/linux-x86_64-debug/lib
cp -r /SFML/build/lib/* build/linux-x86_64-debug/lib/
cp /usr/lib/x86_64-linux-gnu/libFLAC.so.8 build/linux-x86_64-debug/lib/

