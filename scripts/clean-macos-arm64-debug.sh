#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

cd build/macos-arm64-debug/bin
rm -rvf *.o sfml-test
