#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")"

docker build --target sfml-linux -t sfml-linux .

OS=$(uname -s)
    
if [ "$OS" = "Linux" ]; then
    echo "Host OS: Linux - full support - VSCode dev environment, debugger, X11 forwarding with sound"
    docker run --rm -it \
        --name sfml-linux \
        --volume sfml-docker-template-vscode-extensions:/root/.vscode-server/extensions \
        --volume $(pwd):/workspace \
        --volume /tmp/.X11-unix:/tmp/.X11-unix \
        --volume /run/user/1000/pulse:/run/user/1000/pulse \
        --device /dev/snd:/dev/snd \
        --env DISPLAY=$DISPLAY \
        --env PULSE_SERVER=unix:/run/user/1000/pulse/native \
        --network host \
        sfml-linux
else
    echo "Host OS: $OS - limited support - only compilation via scripts"
    docker run --rm -it \
        --name sfml-linux \
        --volume sfml-docker-template-vscode-extensions:/root/.vscode-server/extensions \
        --volume $(pwd):/workspace \
        --network host \
        sfml-linux
fi