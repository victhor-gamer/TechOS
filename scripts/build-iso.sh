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

# Debian Forky no longer ships libfuse2 or libfuse2t64. Some live-build
# versions still request one unconditionally while preparing installer files.
# Patch that optional dependency only for this build, then restore the packaged
# live-build script automatically on exit (including failed builds).
LIVE_BUILD_INSTALLER="/usr/lib/live/build/installer_debian-installer"
LIVE_BUILD_BACKUP=""
restore_live_build_installer() {
    if [ -n "$LIVE_BUILD_BACKUP" ] && [ -f "$LIVE_BUILD_BACKUP" ]; then
        cp -p "$LIVE_BUILD_BACKUP" "$LIVE_BUILD_INSTALLER"
        rm -f "$LIVE_BUILD_BACKUP"
        LIVE_BUILD_BACKUP=""
    fi
}

if [ -f "$LIVE_BUILD_INSTALLER" ] && grep -q 'Check_package_available "libfuse2t64"' "$LIVE_BUILD_INSTALLER"; then
    LIVE_BUILD_BACKUP="$(mktemp)"
    cp -p "$LIVE_BUILD_INSTALLER" "$LIVE_BUILD_BACKUP"
    trap restore_live_build_installer EXIT
    trap 'restore_live_build_installer; exit 1' HUP INT TERM
    python3 - "$LIVE_BUILD_INSTALLER" <<'PY_PATCH'
from pathlib import Path
import sys
path = Path(sys.argv[1])
source = path.read_text()
old = "\t\t\tif [ $(Check_package_available \"libfuse2t64\") -eq 1 ]\n\t\t\tthen\n\t\t\t\tDI_REQ_PACKAGES=\"${DI_REQ_PACKAGES} libfuse2t64\"\n\t\t\telse\n\t\t\t\tDI_REQ_PACKAGES=\"${DI_REQ_PACKAGES} libfuse2\"\n\t\t\tfi"
new = "\t\t\tif [ $(Check_package_available \"libfuse2t64\") -eq 1 ]\n\t\t\tthen\n\t\t\t\tDI_REQ_PACKAGES=\"${DI_REQ_PACKAGES} libfuse2t64\"\n\t\t\telif [ $(Check_package_available \"libfuse2\") -eq 1 ]\n\t\t\tthen\n\t\t\t\tDI_REQ_PACKAGES=\"${DI_REQ_PACKAGES} libfuse2\"\n\t\t\telse\n\t\t\t\tEcho_warning \"Neither libfuse2t64 nor libfuse2 is available; skipping optional Calamares dependency\"\n\t\t\tfi"
if source.count(old) != 1:
    raise SystemExit('Expected libfuse compatibility block not found exactly once')
path.write_text(source.replace(old, new))
PY_PATCH
fi

# Debian Installer images are cached separately by live-build. A stale cache can
# silently mix a Debian 13 installer kernel with a Debian 14 (Forky) live system.
# Remove only those generated installer artifacts so live-build downloads the
# current installer kernel/initrd from the configured Forky mirror.
rm -rf cache/installer_debian-installer binary/install

lb build

IMAGE_NAME="$(sed -n 's/^LB_IMAGE_NAME="\(.*\)"$/\1/p' config/common)"
ARCH="$(dpkg --print-architecture)"
ISO="$ROOT_DIR/${IMAGE_NAME}-${ARCH}.hybrid.iso"
if [ -f "$ISO" ]; then
    sha256sum "$ISO" > "$ISO.sha256"
    echo "ISO created: $ISO"
    echo "Checksum: $ISO.sha256"
else
    echo "Build finished but expected ISO was not found. Check live-build output." >&2
    exit 1
fi
