vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/io.git
  REF 5c4c669f6ebbda56996f1326315222dae9bf281e
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-build-integrate-vcpkg-manifest-features.patch
0003-fix-compile-on-case-sensitive-filesystems.patch
0004-fix-casting-to-void-isn-t-allowed.patch
0005-fix-tests-having-CAN_BCM-defined-is-no-proof-for-sup.patch
0006-chore-be-more-portable-for-socket-types.patch
0007-fix-correct-wrong-goto-in-socket_socketpair-for-non-.patch
0008-fix-move-CLOEXEC-socketpair-creation-out-of-dangling.patch
0009-port-linux-add-support-for-Linux.patch
0010-chore-tests-skip-ConnectionResetError-error-on-WSL-t.patch
0011-fix-tests-drop-O_NONBLOCK-fd-check-for-libuv-managed.patch
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
set(BUILD_PATHS
  "${CURRENT_PACKAGES_DIR}/bin/*.dll"
  "${CURRENT_PACKAGES_DIR}/debug/bin/*.dll"
  "${CURRENT_PACKAGES_DIR}/bin/*.pyd"
  "${CURRENT_PACKAGES_DIR}/debug/bin/*.pyd"
)
vcpkg_copy_pdbs(
  BUILD_PATHS ${BUILD_PATHS}
)
ccp_externalize_apple_debuginfo()
