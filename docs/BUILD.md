# TechOS Build System

## Target

- Base: Debian 13/Forky
- Architecture: AMD64 (x86_64)
- Desktop: Cinnamon with LightDM
- Init: systemd
- Package format: DEB
- Image: hybrid ISO (BIOS and UEFI boot)
- Installer: Debian Installer in live mode

## Build requirements

Build on a Debian/Forky AMD64 system with `live-build`, `debootstrap`, `xorriso`, `squashfs-tools`, `grub-efi-amd64-bin`, `isolinux` and working internet access. Building requires root privileges because live-build creates and configures a chroot.

## Configure

```sh
./scripts/configure-iso.sh
```

This creates the live-build configuration, includes the TechOS Welcome DEB, and prepares the TechOS branding hook.

## Build the ISO

```sh
sudo ./scripts/build-iso.sh
```

The build produces `techos-1.0-unstable-amd64.hybrid.iso` and a SHA-256 checksum file in the project root. Build time and disk usage depend on the mirror and selected packages.

## Included system

The initial image uses the Debian Forky base, Cinnamon, LightDM, NetworkManager, common desktop utilities, live-boot and the Debian Installer. The branding hook sets the TechOS operating-system identity and Cinnamon as the LightDM session. The TechOS Welcome application is installed from the project's DEB package.

## Current limitations

TechOS 1.0 Unstable is an early experimental build. It is not yet a polished or fully tested distribution. Test the ISO in a virtual machine before installing it on physical hardware. Hardware support, installer behavior, branding, upgrades and package signing still require validation.
