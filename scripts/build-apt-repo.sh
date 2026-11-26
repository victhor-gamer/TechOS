#!/bin/sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
PACKAGE_DIR="$ROOT_DIR/build"
OUTPUT_DIR="$ROOT_DIR/public"
POOL_DIR="$OUTPUT_DIR/pool/main"
BINARY_DIR="$OUTPUT_DIR/dists/unstable/main/binary-amd64"

if ! command -v dpkg-scanpackages >/dev/null 2>&1; then
    echo "Error: dpkg-scanpackages is required. Install dpkg-dev." >&2
    exit 1
fi

PACKAGE_FILE="$PACKAGE_DIR/techos-welcome_0.1.0_all.deb"
if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Error: package not found: $PACKAGE_FILE" >&2
    exit 1
fi

rm -rf "$OUTPUT_DIR"
mkdir -p "$POOL_DIR" "$BINARY_DIR"
cp "$PACKAGE_FILE" "$POOL_DIR/"

(
    cd "$OUTPUT_DIR"
    dpkg-scanpackages --arch all pool /dev/null > "$BINARY_DIR/Packages"
    gzip -9 -kf "$BINARY_DIR/Packages"
)

cat > "$OUTPUT_DIR/dists/unstable/Release" <<EOF
Origin: TechOS
Label: TechOS
Suite: unstable
Codename: unstable
Architectures: amd64
Components: main
Description: Experimental APT repository for TechOS
Date: $(date -Ru)
EOF

(
    cd "$OUTPUT_DIR"
    apt-ftparchive release dists/unstable >> dists/unstable/Release
)

echo "APT repository generated at: $OUTPUT_DIR"
