#!/bin/sh
set -eu
command -v gpg >/dev/null 2>&1 || { echo "Install GnuPG: sudo apt install gnupg" >&2; exit 1; }
echo "Creating a dedicated TechOS archive-signing key."
echo "Use RSA 4096 bits and a strong passphrase when prompted."
echo "Keep the private key offline. Never commit or share it."
gpg --full-generate-key
echo
gpg --list-secret-keys --keyid-format LONG
