[private]
default:
    @just --list

# Build the custom image
[group('Container')]
build-image:
    #!/usr/bin/env bash
    set -euxo pipefail
    podman build --tag "sean-silverblue:latest" --file "./Containerfile"

# Run the custom image headless under Podman
[group('Container')]
run-image:
    #!/usr/bin/env bash
    set -euxo pipefail
    podman run --rm -it "sean-silverblue:latest" /bin/bash
