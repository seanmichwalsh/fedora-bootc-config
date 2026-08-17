#!/usr/bin/env bash
set -euxo pipefail

dnf5 install -y \
     grub2-efi-x64 \
     grub2-efi-x64-modules \
     shim-x64 \
     grub2-common \
     grub2-pc-modules \
     grub2-efi-x64-cdboot \
     squashfs-tools \
     xorrisofs \
     isomd5sum

dnf clean all

mkdir -p /boot/efi
cp -ra /usr/lib/efi/*/*/EFI /boot/efi
