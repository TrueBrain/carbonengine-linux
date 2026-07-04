vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/blue.git
  REF 245d07a431099232cb6d42c497467d2e7daea097
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-build-integrate-vcpkg-manifest-features.patch
0003-chore-update-CMakePresets-to-be-more-like-the-rest.patch
0004-chore-update-.gitignore-to-be-more-like-the-rest.patch
0005-fix-compile-on-case-sensitive-filesystems.patch
0006-fix-use-empty-vector-instead-of-old-style.patch
0007-port-linux-add-support-for-Linux.patch
0008-fix-linux-un-pack-functions-for-long-long-aren-t-def.patch
    # END EXPORTED PATCHES
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS
  -DBUILD_TESTING=OFF
  -DVCPKG_USE_HOST_TOOLS=ON
  -DVCPKG_HOST_TRIPLET=${HOST_TRIPLET}
  -DCMAKE_BUILD_TYPE=${CARBON_BUILD_TYPE}
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
set(BUILD_PATHS
    "${CURRENT_PACKAGES_DIR}/bin/*.pyd"
    "${CURRENT_PACKAGES_DIR}/debug/bin/*.pyd"
)
vcpkg_copy_pdbs(BUILD_PATHS ${BUILD_PATHS})
ccp_externalize_apple_debuginfo()
