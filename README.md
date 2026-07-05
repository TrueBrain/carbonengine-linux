# CarbonEngine - Ported to Linux

This repository provides a [vcpkg](https://github.com/microsoft/vcpkg) registry
for building [CarbonEngine](https://github.com/carbonengine) on Linux
(and, where applicable, Emscripten), including the patches, triplets, and
toolchain files needed to make the upstream project build outside of its
original Windows/MacOS-only environment.

It is still a work in progress.
Not all repositories are available yet, and some parts are stubbed.

## Contents

- `ports` — the vcpkg ports for CarbonEngine's libraries, including
  patches required for Linux support.
- `triplets/` — vcpkg triplets for `x64-linux` builds (release, debug,
  internal, and trinitydev variants).
- `toolchains/` — CMake toolchain files used when configuring the port.

## Usage

```bash
git clone https://github.com/TrueBrain/carbonengine-linux

# Replace "core" with any carbonengine repository you like to work on.
git clone https://github.com/carbonengine/core
cd core

git submodule update --init --recursive

# Introduce linux presets to CMake.
ln -s ../carbonengine-linux/CMakeUserPresets.json CMakeUserPresets.json

# Apply all the patches to the repository. Replace "core" with the checked-out repository name.
git am ../carbonengine-linux/ports/carbon-core/*.patch

cmake --preset x64-linux-debug
cmake --build .cmake-build-x64-linux-debug
ctest --test-dir .cmake-build-x64-linux-debug
```

## Tests hang with "blue"

Make sure you have these things prepared:
- Run a non-release (or have `eve_crashmon` available).
- Run LogLite (via EVE Launcher -> Settings -> Tools -> LogLite).
- Have `fr_FR` locale installed.

Without the first two, the tests just hang.
Without the last one, a single tests will fail.

## Vulkan support

In order for graphics to work, carbonengine/trinity needs to communicate with a graphics API.
Trinity has built-in support for DX11, DX12, and Metal.
All three don't work on Linux.

Claude's Fable was tasked to write a Vulkan backend; although functional, performance and correctness might be lacking.
This Vulkan backend was mostly added to proof everything else is working.
Not to facilitate a production-ready implementation.

Use with care.

## License

MIT, see [LICENSE.md](LICENSE.md).
