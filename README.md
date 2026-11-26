# TechOS

**O futuro que o passado imaginou, continua.**

TechOS is an experimental Debian-based Linux distribution project.

## Project goals

- Build a customized Debian-based operating system.
- Target AMD64 (x86_64) computers first.
- Use Cinnamon as the planned desktop environment.
- Develop original TechOS applications and system tools.
- Create a recognizable Frutiger Aero-inspired visual identity.

## Current status

**TechOS 1.0 Unstable — early development.**

The repository contains the TechOS Welcome application, a signed APT repository, and an initial live-build configuration for a bootable Debian Forky/Cinnamon ISO with the Debian Installer. The ISO is experimental and still requires a successful build and VM testing.

## First application: TechOS Welcome

Run on a Debian-based development system with Python 3 and Tkinter:

```sh
python3 apps/techos-welcome/src/techos_welcome.py
```

Build its Debian package (requires `dpkg-deb`):

```sh
sh scripts/build-deb.sh
```

Configure and build the experimental ISO with `./scripts/configure-iso.sh` followed by `sudo ./scripts/build-iso.sh`. See [Build Guide](docs/BUILD.md).

See [Development Guide](docs/DEVELOPMENT.md) and [Testing Guide](docs/TESTING.md).

## Documentation

- [About TechOS](docs/ABOUT.md)
- [Roadmap](docs/ROADMAP.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Features](docs/FEATURES.md)
- [Package Management](docs/PACKAGES.md)
- [Build System](docs/BUILD.md)
- [Installation](docs/INSTALL.md)
- [Releases](docs/RELEASES.md)
- [Security Policy](docs/SECURITY.md)
- [Contributing](docs/CONTRIBUTING.md)

## Contributing

Contributions, bug reports, and feature suggestions are welcome. Read [CONTRIBUTING.md](docs/CONTRIBUTING.md) before opening a pull request.

## License

TechOS is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE).
