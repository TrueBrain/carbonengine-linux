# This toolchain is meant for use inside a vcpkg triplet. See `README.md` for more details.
include($ENV{VCPKG_ROOT}/scripts/toolchains/linux.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../toolchains/x64-linux-carbon.cmake)
