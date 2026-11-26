# TechOS Roadmap

Development plan for the TechOS project.

## TechOS 1.0 Unstable

### 1. Foundation
- [x] Create the GitHub repository
- [x] Add initial project documentation
- [x] Establish the initial source and package directory structure
- [x] Select Debian as the base
- [x] Select AMD64 (x86_64) as the first target architecture
- [x] Select Cinnamon as the planned desktop environment

### 2. Desktop identity
- [ ] Define the official TechOS visual identity
- [ ] Create the Frutiger Aero-inspired desktop theme
- [ ] Create original icons and wallpapers
- [ ] Customize the login experience

### 3. Original applications
- [x] Create the first TechOS Welcome prototype
- [ ] Integrate TechOS Welcome with the desktop session
- [ ] Develop TechOS Center
- [ ] Develop TechOS Store
- [ ] Develop TechOS Update
- [ ] Develop TechOS Info

### 4. System engineering
- [x] Add an initial Debian package build script
- [ ] Define the Debian release used as the base
- [ ] Configure the default package selection
- [ ] Add automated tests and build validation
- [ ] Test packages in a clean Debian AMD64 virtual machine

### 5. Distribution
- [ ] Implement the complete ISO build system
- [ ] Create a bootable AMD64 ISO
- [ ] Test boot and installation in a virtual machine
- [ ] Publish checksums and release notes
- [ ] Publish the first experimental release

## Future goals

- Create an official TechOS APT repository
- Develop additional original system tools
- Evaluate support for other architectures
- Improve performance, accessibility, and usability

## Current status

TechOS is in early development. The Welcome application is a prototype; the complete operating system, installer, and ISO are not yet available.

- Base: Debian
- Primary architecture: AMD64 (x86_64)
- Planned desktop: Cinnamon
- Version: 1.0 Unstable
