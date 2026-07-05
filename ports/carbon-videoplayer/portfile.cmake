vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/videoplayer.git
  REF 2c4ac902d1474238097e70ab5c6e7f4bf7bc6755
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-build-integrate-vcpkg-manifest-features.patch
0003-chore-update-CMakePresets-to-be-more-like-the-rest.patch
0004-port-linux-add-support-for-Linux.patch
    # END EXPORTED PATCHES
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
