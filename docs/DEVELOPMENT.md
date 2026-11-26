# TechOS Development

This document describes the first local development workflow.

## Requirements

The initial TechOS Welcome prototype uses Python 3 and Tkinter.
To build its Debian package, install the Debian package tools:

```sh
sudo apt install python3 python3-tk dpkg-dev
```

## Run the application from the repository

```sh
python3 apps/techos-welcome/src/techos_welcome.py
```

## Build the Debian package

From the repository root:

```sh
sh scripts/build-deb.sh
```

The generated package will be written to:

```
build/techos-welcome_0.1.0_all.deb
```

Install it on a test Debian/TechOS system with:

```sh
sudo apt install ./build/techos-welcome_0.1.0_all.deb
```

Only install experimental packages on a test system or virtual machine.

## Current limitations

- TechOS Welcome is an early prototype.
- The interface currently uses Tkinter, not GTK.
- No TechOS ISO or APT repository is produced by this script.
- The package targets Debian-compatible systems with Python 3 and Tkinter.
