#!/bin/sh
set -eu

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
PUBLIC_DIR="${1:-$ROOT_DIR/public}"
RELEASE_FILE="$PUBLIC_DIR/dists/unstable/Release"
KEY_ID="${TECHOS_GPG_KEY_ID:-}"

if [ -z "$KEY_ID" ]; then
    printf "Fingerprint ou ID da chave GPG: "
    read KEY_ID
fi

if [ -z "$KEY_ID" ]; then
    echo "Erro: nenhuma chave foi informada." >&2
    exit 1
fi

if [ ! -f "$RELEASE_FILE" ]; then
    echo "Erro: arquivo Release não encontrado em $RELEASE_FILE" >&2
    echo "Extraia primeiro o artefato techos-apt-unsigned nessa pasta." >&2
    exit 1
fi

if ! gpg --list-secret-keys "$KEY_ID" >/dev/null 2>&1; then
    echo "Erro: a chave privada $KEY_ID não está disponível neste computador." >&2
    exit 1
fi

gpg --batch --yes --local-user "$KEY_ID" --clearsign \
    --output "$PUBLIC_DIR/dists/unstable/InRelease" "$RELEASE_FILE"

gpg --batch --yes --local-user "$KEY_ID" --detach-sign --armor \
    --output "$PUBLIC_DIR/dists/unstable/Release.gpg" "$RELEASE_FILE"

gpg --batch --export "$KEY_ID" > "$PUBLIC_DIR/techos-archive-keyring.gpg"

echo "Repositório assinado localmente."
echo "A chave privada não foi enviada ao GitHub."
