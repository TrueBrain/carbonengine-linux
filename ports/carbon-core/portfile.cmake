vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/core.git
  REF 250df5221bdbb981a46669ac7a7e72ed33e099e0
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-fix-be-consistent-with-casing-of-Ccp.patch
0002-fix-detect-std-atomic-correctly-for-GCC-5.patch
0003-build-update-vcpkg-registry-to-HTTPS.patch
0004-build-integrate-vcpkg-manifest-features.patch
0005-chore-include-all-required-system-headers.patch
0006-chore-fix-compiling-telemetry-module-when-disabled.patch
0007-port-linux-add-support-for-Linux.patch
0008-port-emscripten-add-Emscripten-specific-fixes.patch
    # END EXPORTED PATCHES
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
      documentation BUILD_DOCUMENTATION
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS
  ${FEATURE_OPTIONS}
  -DBUILD_TESTING=OFF
  -DVCPKG_USE_HOST_TOOLS=ON
  -DVCPKG_HOST_TRIPLET=${HOST_TRIPLET}
  -DCMAKE_BUILD_TYPE=${CARBON_BUILD_TYPE}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
vcpkg_copy_pdbs()
ccp_externalize_apple_debuginfo()
