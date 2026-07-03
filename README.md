# CarbonEngine - Ported to Linux

This repository provides a [vcpkg](https://github.com/microsoft/vcpkg) registry
for building [CarbonEngine](https://github.com/carbonengine) on Linux
(and, where applicable, Emscripten), including the patches, triplets, and
toolchain files needed to make the upstream project build outside of its
original Windows/MacOS-only environment.

## Contents

- `ports` — the vcpkg ports for CarbonEngine's libraries, including
  patches required for Linux support.
- `triplets/` — vcpkg triplets for `x64-linux` builds (release, debug,
  internal, and trinitydev variants).
- `toolchains/` — CMake toolchain files used when configuring the port.

## License

MIT, see [LICENSE.md](LICENSE.md).
