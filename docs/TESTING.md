# TechOS Testing

## General rule

Test experimental changes in a virtual machine whenever possible. Do not use important personal data or a daily-use installation as the first test target.

## TechOS Welcome

Run from the repository root:

```sh
python3 apps/techos-welcome/src/techos_welcome.py
```

Requirements: Python 3 and Tkinter.

## Build the Debian package

Install the package tools on Debian:

```sh
sudo apt install python3 python3-tk dpkg-dev
```

Then run:

```sh
sh scripts/build-deb.sh
```

## Checks before merging

- [ ] Application starts without errors.
- [ ] Desktop launcher is installed in the package.
- [ ] Package metadata is valid.
- [ ] Package installs in a disposable Debian virtual machine.
- [ ] Documentation reflects the current behavior.

## Known limitations

The current package script builds only the TechOS Welcome application. It does not generate a TechOS ISO.
