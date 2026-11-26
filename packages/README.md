# TechOS Packages

This directory contains Debian package source layouts.

Each package should use a dedicated directory with a Debian control file under `DEBIAN/` and its installable filesystem tree under paths such as `usr/bin/`, `usr/share/`, and `usr/lib/`.

The first example is `techos-welcome/`.

Build the initial package from the repository root:

```sh
sh scripts/build-deb.sh
```

The build output is local and is not committed to the repository.
