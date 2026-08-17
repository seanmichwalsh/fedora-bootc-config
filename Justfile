[private]
default:
    @just --list

# Build the custom image
[group('Container')]
build-container:
    #!/usr/bin/env bash
    set -euxo pipefail
    podman build --tag "sean-silverblue:latest" --file "./Containerfile"

# Run the custom image headless under Podman
[group('Container')]
run-container:
    #!/usr/bin/env bash
    set -euxo pipefail
    podman run --rm -it "sean-silverblue:latest" /bin/bash

[group('Image')]
build-image:
    #!/usr/bin/env bash
    set -euxo pipefail

    if [ ! -d "./output" ]; then
        mkdir output
    fi

    podman run \
        --rm \
        -it \
        --privileged \
        --pull=newer \
        --security-opt=label=type:unconfined_t \
        -v ./output:/output \
        -v ~/.local/share/containers/storage:/var/lib/containers/storage \
        ghcr.io/osbuild/image-builder:latest \
        build qcow2 \
        --in-vm \
        --bootc-default-fs=btrfs \
        --bootc-ref=localhost/sean-silverblue:latest \
