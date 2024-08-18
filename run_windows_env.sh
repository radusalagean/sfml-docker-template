#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

docker build --target sfml-windows -t sfml-windows .

docker run --rm -it \
  --name sfml-windows \
  --volume sfml-docker-template-vscode-extensions:/root/.vscode-server/extensions \
  --volume $(pwd):/workspace \
  sfml-windows