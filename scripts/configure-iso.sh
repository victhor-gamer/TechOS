#!/bin/sh
set -eu
ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [ "$(dpkg --print-architecture)" != amd64 ]; then
    echo "TechOS 1.0 Unstable ISO currently targets amd64 only." >&2
    exit 1
fi

sh scripts/build-deb.sh
mkdir -p config/packages.chroot
cp build/techos-welcome_0.1.0_all.deb config/packages.chroot/

lb config \
    --mode debian \
    --distribution forky \
    --architectures amd64 \
    --binary-images iso-hybrid \
    --bootloaders grub-efi,syslinux \
    --debian-installer live \
    --archive-areas main \
    --apt-recommends true \
    --iso-application TechOS \
    --iso-publisher 'TechOS Project' \
    --iso-volume 'TECHOS_1_0_UNSTABLE' \
    --image-name techos-1.0-unstable-amd64

echo "TechOS live-build configuration generated."
