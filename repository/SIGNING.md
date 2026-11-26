# Assinatura GPG do repositório TechOS

O TechOS usa uma chave OpenPGP própria para que o APT possa verificar a autenticidade dos metadados do repositório.

## Modelo de segurança

- A chave privada fica somente no computador do responsável pela publicação.
- A chave privada e sua senha nunca devem ser colocadas no GitHub, em arquivos do projeto ou em conversas.
- O GitHub Actions apenas monta o repositório APT sem assinatura e disponibiliza um artefato temporário.
- O responsável baixa o artefato, assina localmente e só então publica os arquivos assinados.
- A chave pública pode ser distribuída junto do repositório; clientes usam `signed-by` para confiar apenas nessa chave.

Peça ajuda a um responsável de confiança para criar e guardar a chave. Faça uma cópia de segurança offline e protegida da chave privada.

## 1. Criar a chave

Em um computador confiável com GnuPG instalado:

```sh
sudo apt install gnupg
sh scripts/generate-archive-key.sh
```

Escolha uma chave OpenPGP forte (RSA 4096 bits é uma opção compatível) e defina uma senha longa. Guarde o fingerprint exibido por:

```sh
gpg --fingerprint
```

Não compartilhe a chave privada nem sua senha.

## 2. Gerar o repositório

Envie as alterações para a branch `main`. O GitHub Actions criará o artefato `techos-apt-unsigned`. Ele não publica um repositório confiável ainda: falta a assinatura.

Na página de Actions do GitHub, abra a execução concluída e baixe o artefato. Extraia seu conteúdo para a pasta `public/` na cópia local do projeto.

## 3. Assinar localmente

No computador que contém a chave privada, execute:

```sh
sh scripts/sign-apt-repo.sh
```

Informe o fingerprint ou ID da chave quando solicitado. O GnuPG poderá pedir a senha da chave. O script cria `InRelease`, `Release.gpg` e `techos-archive-keyring.gpg`.

Nunca desative a proteção por senha para facilitar a automação.

## 4. Publicar

Publique o conteúdo da pasta `public/` somente depois de conferir a assinatura e os arquivos gerados. A publicação do conteúdo assinado deve ser feita por um responsável com acesso ao repositório. Configure o GitHub Pages para servir apenas a branch/pasta escolhida para os arquivos públicos.

Antes de distribuir o repositório, verifique a assinatura em uma máquina de teste e confirme o fingerprint da chave pública por um canal oficial independente.

## 5. Instalação pelos usuários

Instale a chave pública em um keyring dedicado e configure a fonte APT com `signed-by=/usr/share/keyrings/techos-archive-keyring.gpg`. Não use `apt-key` e não torne essa chave confiável para todos os repositórios do sistema.

## Limites

A assinatura GPG confirma que os metadados foram assinados por quem controla a chave e ajuda a detectar alterações. Ela não garante que os pacotes sejam livres de bugs ou seguros. Proteja também a conta GitHub, revise alterações e documente rotação e revogação da chave.
