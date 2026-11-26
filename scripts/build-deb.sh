#!/bin/sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
PACKAGE_DIR="$ROOT_DIR/packages/techos-welcome"
APP_SOURCE="$ROOT_DIR/apps/techos-welcome/src/techos_welcome.py"
STAGE_DIR="$ROOT_DIR/build/techos-welcome"
OUTPUT_DIR="$ROOT_DIR/build"

if ! command -v dpkg-deb >/dev/null 2>&1; then
    echo "Error: dpkg-deb is required. Install the dpkg package tools." >&2
    exit 1
fi

if [ ! -f "$APP_SOURCE" ]; then
    echo "Error: TechOS Welcome source file was not found." >&2
    exit 1
fi

rm -rf "$STAGE_DIR"
mkdir -p "$STAGE_DIR/DEBIAN" \
    "$STAGE_DIR/usr/bin" \
    "$STAGE_DIR/usr/lib/techos-welcome" \
    "$STAGE_DIR/usr/share/applications"

cp -R "$PACKAGE_DIR/DEBIAN/." "$STAGE_DIR/DEBIAN/"
cp "$PACKAGE_DIR/usr/bin/techos-welcome" "$STAGE_DIR/usr/bin/"
cp "$PACKAGE_DIR/usr/share/applications/techos-welcome.desktop" \
    "$STAGE_DIR/usr/share/applications/"
cp "$APP_SOURCE" "$STAGE_DIR/usr/lib/techos-welcome/"

chmod 0755 "$STAGE_DIR/usr/bin/techos-welcome"
mkdir -p "$OUTPUT_DIR"
dpkg-deb --root-owner-group --build "$STAGE_DIR" \
    "$OUTPUT_DIR/techos-welcome_0.1.0_all.deb"

echo "Package created: $OUTPUT_DIR/techos-welcome_0.1.0_all.deb"
