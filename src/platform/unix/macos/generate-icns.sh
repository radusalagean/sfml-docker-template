#!/bin/bash

set -e

cd $(dirname "${BASH_SOURCE[0]}")

png2icns icon.icns IconAssets.iconset/icon_*.png
