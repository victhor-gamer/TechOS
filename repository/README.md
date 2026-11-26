# TechOS APT Repository

This directory contains the configuration and documentation for the experimental TechOS APT repository.

The repository is published separately through GitHub Pages. The publication workflow builds the Debian packages and generates the APT metadata.

## Channel

- Distribution: `unstable`
- Component: `main`
- Architecture: `amd64`

## Current security status

This repository is an early development setup and is not yet signed with a TechOS archive key. Do not configure it as a trusted system-wide source on a daily-use machine. A signed archive and documented key-verification process are required before general distribution.

## Publication

The workflow `.github/workflows/apt-repository.yml` builds the package and publishes the generated repository to GitHub Pages. Enable GitHub Pages with **GitHub Actions** as the build and deployment source in the repository settings.
