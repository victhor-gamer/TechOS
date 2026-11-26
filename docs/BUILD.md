# TechOS Build System

Official build documentation for TechOS.

## Target

- Base distribution: Debian
- Architecture: AMD64 (x86_64)
- Desktop environment: Cinnamon
- Init system: systemd
- Package format: DEB

## Current build tooling

The repository currently includes an initial Debian package build script for TechOS Welcome:

```sh
sh scripts/build-deb.sh
```

It creates a local `.deb` package under `build/`. It does not build a complete operating-system ISO.

## Future ISO build process

The planned ISO pipeline is:

1. Select and pin a Debian release.
2. Prepare a reproducible Debian AMD64 build environment.
3. Install the selected base and desktop packages.
4. Apply TechOS configuration and branding.
5. Include tested TechOS packages.
6. Generate a bootable ISO.
7. Test boot and installation in a virtual machine.
8. Publish checksums and release notes.

## Candidate tools

- live-build
- debootstrap
- xorriso
- APT

The final toolchain has not yet been selected.

## Status

The full TechOS ISO build system is not implemented.
