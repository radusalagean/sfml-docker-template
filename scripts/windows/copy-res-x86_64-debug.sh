#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/../..
cd $PROJECT_ROOT_DIR

mkdir -p build/windows-x86_64-debug/res
cp -rv res/* build/windows-x86_64-debug/res
