vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/resources.git
  REF 77d0867388370a31a2f78b9f2ddbcd23deec8bc1
  HEAD_REF main
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-build-integrate-vcpkg-manifest-features.patch
0003-chore-update-CMakePresets-to-be-more-like-the-rest.patch
0004-chore-update-.gitignore-to-be-more-like-the-rest.patch
0005-chore-include-all-required-system-headers.patch
0006-fix-CreateBundle-ignore-result-from-GetDataStream.patch
0007-fix-compile-on-case-sensitive-filesystems.patch
0008-port-linux-add-support-for-Linux.patch
0009-fix-order-in-resource-groups-depend-on-filesystem.patch
0010-fix-index-files-with-canonical-lowercase-paths-don-t.patch
    # END EXPORTED PATCHES
)

vcpkg_check_features(OUT_FEATURE_OPTIONS RESOURCES_FEATURE_OPTIONS
        FEATURES
        tests BUILD_TESTING
        docs  BUILD_DOCUMENTATION
)

set(EXTRA_OPTIONS "")
if("tests" IN_LIST FEATURES)
    list(APPEND EXTRA_OPTIONS -DGTest_DIR=${VCPKG_INSTALLED_DIR}/${TARGET_TRIPLET}/share/gtest)
endif()

vcpkg_cmake_configure(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS
            ${RESOURCES_FEATURE_OPTIONS}
            -DVCPKG_USE_HOST_TOOLS=ON
            -DVCPKG_HOST_TRIPLET=${HOST_TRIPLET}
            -DCMAKE_BUILD_TYPE=${CARBON_BUILD_TYPE}
            ${EXTRA_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_install_copyright(
        FILE_LIST
        "${SOURCE_PATH}/LICENSE.txt"
        "${SOURCE_PATH}/NOTICE.md"
)

vcpkg_cmake_config_fixup()
vcpkg_copy_pdbs()
