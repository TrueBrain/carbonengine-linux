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

## Usage

```bash
git clone https://github.com/microsoft/vcpkg microsoft-vcpkg
git clone https://github.com/TrueBrain/carbonengine-linux

# Replace "core" with any carbonengine repository you like to work on.
git clone https://github.com/carbonengine/core
cd core

cmake . -B cmake-build-host -DCMAKE_TOOLCHAIN_FILE=../microsoft-vcpkg/scripts/buildsystems/vcpkg.cmake -DVCPKG_OVERLAY_TRIPLETS=../carbonengine-linux/triplets -DVCPKG_OVERLAY_PORTS=../carbonengine-linux/ports
cmake --build cmake-build-host
ctest --test-dir cmake-build-host
```

## License

MIT, see [LICENSE.md](LICENSE.md).
