#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd $PROJECT_ROOT_DIR

mkdir -p build/linux-x86_64-debug/res
cp -rv res/* build/linux-x86_64-debug/res