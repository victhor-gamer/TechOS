#!/bin/sh
set -eu
ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
PUBLIC_DIR="$ROOT_DIR/public"
RELEASE_FILE="$PUBLIC_DIR/dists/unstable/Release"
: "${TECHOS_GPG_PRIVATE_KEY:?Set TECHOS_GPG_PRIVATE_KEY in GitHub Actions secrets}"
: "${TECHOS_GPG_PASSPHRASE:?Set TECHOS_GPG_PASSPHRASE in GitHub Actions secrets}"
: "${TECHOS_GPG_KEY_ID:?Set TECHOS_GPG_KEY_ID as a GitHub Actions variable}"
[ -f "$RELEASE_FILE" ] || { echo "Release file not found." >&2; exit 1; }
GNUPGHOME="$(mktemp -d)"
export GNUPGHOME
chmod 700 "$GNUPGHOME"
trap 'rm -rf "$GNUPGHOME"' EXIT HUP INT TERM
printf '%s\n' "$TECHOS_GPG_PRIVATE_KEY" | gpg --batch --import
gpg --batch --yes --pinentry-mode loopback --passphrase "$TECHOS_GPG_PASSPHRASE" --local-user "$TECHOS_GPG_KEY_ID" --clearsign --output "$PUBLIC_DIR/dists/unstable/InRelease" "$RELEASE_FILE"
gpg --batch --yes --pinentry-mode loopback --passphrase "$TECHOS_GPG_PASSPHRASE" --local-user "$TECHOS_GPG_KEY_ID" --detach-sign --armor --output "$PUBLIC_DIR/dists/unstable/Release.gpg" "$RELEASE_FILE"
gpg --batch --export "$TECHOS_GPG_KEY_ID" > "$PUBLIC_DIR/techos-archive-keyring.gpg"
echo "APT repository signed successfully."
