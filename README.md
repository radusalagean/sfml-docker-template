# sfml-docker-template

A template for creating a portable dev environment with cross-compilation support for macOS, Windows and Linux targets.

## Containers

### Linux container (Main Development Environment)

- This container can be used for:
    - Development (tested on host OS: Linux)
        - Supports debugging and running from VSCode via `launch.json` (`F5` and `Ctrl / Cmd` + `F5`)
    - Compiling binaries for Linux (tested on host OS: Linux, macOS, Windows)

- VSCode extensions for development in the container:
    - C/C++ Extension Pack
    - Dev Containers
    - Docker

- Before starting the container, allow X11 forwarding. On the host the Linux machine:
    ```
    xhost local:docker*
    ```
- Start the container with:
    ```
    docker compose up linux -d
    ```
- Once the container started, add the repo as a safe repo:
    ```
    git config --global --add safe.directory <path/to/repo>
    ```

### macOS container

- This container can be used for compiling binaries for macOS (tested from host OS: Linux, macOS, Windows)
- Start the container with:
    ```
    docker compose up macos -d
    ```

### Windows container

- This container can be used for compiling binaries for Windows (tested from host OS: Linux, macOS, Windows)
- Start the container with:
    ```
    docker compose up windows -d
    ```

## Tasks

- `clean-*` - Removes existing build
- `setup-*` - Prepares the shared libraries in the run directory
- `copy-res-*` - Prepares the assets in the run directory
- `compile-*` - Compiles the executable