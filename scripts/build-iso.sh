#!/bin/sh
set -eu
ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [ "$(id -u)" -ne 0 ]; then
    echo "Run this script as root: sudo ./scripts/build-iso.sh" >&2
    exit 1
fi

if [ ! -f config/common ] || [ ! -f config/package-lists/techos.list.chroot ]; then
    echo "ISO configuration missing. Run ./scripts/configure-iso.sh first." >&2
    exit 1
fi

lb build

ISO="$ROOT_DIR/techos-1.0-unstable-amd64.hybrid.iso"
if [ -f "$ISO" ]; then
    sha256sum "$ISO" > "$ISO.sha256"
    echo "ISO created: $ISO"
    echo "Checksum: $ISO.sha256"
else
    echo "Build finished but expected ISO was not found. Check live-build output." >&2
    exit 1
fi
