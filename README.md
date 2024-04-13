# sfml-docker-template

A template for creating a portable dev environment with cross-compilation support for macOS, and soon for both Windows and Linux targets.


Docker commands:
`docker system prune -a` - Cleanup unused Docker resources
`docker compose up setup-env-macos-arm64-debug` - Setup macOS dev environment
`docker compose up interactive-env` - Run interactive dev environment
