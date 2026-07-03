vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/parser.git
  REF b58a68538fe4ae63b3854b391744b86f561b901b
  HEAD_REF main
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-chore-update-.gitignore-to-be-more-like-the-rest.patch
0002-build-update-vcpkg-registry-to-HTTPS.patch
0003-build-integrate-vcpkg-manifest-features.patch
0004-fix-compile-on-case-sensitive-filesystems.patch
0005-chore-include-all-required-system-headers.patch
0006-fix-__builtin_ctzll-is-built-in-on-Linux-too.patch
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
