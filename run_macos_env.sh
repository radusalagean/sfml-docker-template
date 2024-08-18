#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

docker build --target sfml-macos -t sfml-macos .

docker run --rm -it \
  --name sfml-macos \
  --volume sfml-docker-template-vscode-extensions:/root/.vscode-server/extensions \
  --volume $(pwd):/workspace \
  sfml-macos