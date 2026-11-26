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

The repository currently contains project documentation and the first TechOS Welcome application prototype. A complete operating-system ISO, installer, and dedicated APT repository do not exist yet.

## First application: TechOS Welcome

Run on a Debian-based development system with Python 3 and Tkinter:

```sh
python3 apps/techos-welcome/src/techos_welcome.py
```

Build its Debian package (requires `dpkg-deb`):

```sh
sh scripts/build-deb.sh
```

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
