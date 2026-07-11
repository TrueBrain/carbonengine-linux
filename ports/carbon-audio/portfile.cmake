vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/audio.git
  REF dfa86c9b96a702b8249ca02485bcf321bfbddeef
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-fix-compile-on-case-sensitive-filesystems.patch
0003-fix-long-long-isn-t-the-same-as-int64_t.patch
0004-feat-stub-for-wwise-to-compile-without-SDK.patch
0005-port-linux-add-support-for-Linux.patch
    # END EXPORTED PATCHES
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS
    -DBUILD_TESTING=OFF
    -DCMAKE_BUILD_TYPE=${CARBON_BUILD_TYPE}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
vcpkg_copy_pdbs()
ccp_externalize_apple_debuginfo()
