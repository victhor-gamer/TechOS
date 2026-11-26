# TechOS archive signing key

TechOS uses a dedicated OpenPGP key managed with GNU Privacy Guard (GnuPG).

## Create the key

On a trusted maintainer computer, run:

```sh
sudo apt install gnupg
sh scripts/generate-archive-key.sh
```

Choose RSA with at least 3072 bits (4096 recommended), and set a strong passphrase. Keep an offline backup of the private key. Do not commit it or put it in a public repository.

## Configure GitHub Actions

On the trusted maintainer computer, export the private key in ASCII-armored form:

```sh
gpg --armor --export-secret-keys YOUR_KEY_ID
```

Add that output as repository Actions secret `TECHOS_GPG_PRIVATE_KEY`; add the passphrase as secret `TECHOS_GPG_PASSPHRASE`; add the long key ID from `gpg --list-secret-keys --keyid-format LONG` as Actions variable `TECHOS_GPG_KEY_ID`.

Never paste the private key or passphrase into a commit, issue, pull request, or chat. Ask a parent/guardian or trusted adult to help manage these publishing credentials. Restrict repository write access. For public releases, use a protected GitHub Environment with manual approval.

The published public key is `techos-archive-keyring.gpg`. Clients must install it into a dedicated APT keyring and configure the source with `signed-by=/usr/share/keyrings/techos-archive-keyring.gpg`. Do not use `apt-key` or globally trust the repository.

Before public distribution, independently verify the public-key fingerprint through an official TechOS channel and document key rotation and revocation.
