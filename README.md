# sfml-docker-template

A template for creating a portable dev environment with cross-compilation support for macOS, Windows and soon for Linux targets.


### Docker commands:

`docker system prune -a` - Cleanup unused Docker resources

`docker compose up setup-env-macos-arm64-debug` - Setup macOS ARM64 Debug environment

`docker compose up setup-env-windows-x86_64-debug` - Setup Windows x86_64 Debug environment

`docker compose up setup-env-linux-x86_64-debug` - Setup Linux x86_64 Debug environment

`docker compose up interactive-env-macos-arm64` - Run ARM64 macOS Debug interactive dev environment

`docker compose up interactive-env-windows-x86_64` - Run Windows x86_64 Debug interactive dev environment

`docker compose up interactive-env-linux-x86_64` - Run Windows x86_64 Debug interactive dev environment
