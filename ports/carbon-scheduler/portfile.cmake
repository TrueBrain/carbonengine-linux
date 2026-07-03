vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/scheduler.git
  REF 327303b539aaf1850ebcc4ad73460e3a61855cff
  HEAD_REF main
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-build-downgrade-to-CMake-3.28.patch
0003-build-integrate-vcpkg-manifest-features.patch
0004-port-linux-enable-Linux-support-in-CMake.patch
0005-port-linux-bool-is-1-byte-on-Linux-causing-out-of-bo.patch
0006-fix-validate-pointer-before-use.patch
0007-fix-tests-export-dynamic-symbols-from-SchedulerCapiT.patch
0008-fix-tests-don-t-decref-the-borrowed-sys.modules-refe.patch
0009-fix-missing-incref-with-GetThreadScheduleManager.patch
0010-fix-SetNNNCallback-must-take-ownership-of-callback-o.patch
0011-fix-tests-don-t-double-decref-fooCallable.patch
0012-fix-tests-clear-pending-exception-in-PyTasklet_Inser.patch
0013-fix-PyChannel_SendException-over-decrefs-caller-supp.patch
    # END EXPORTED PATCHES
)

vcpkg_cmake_configure(
  SOURCE_PATH ${SOURCE_PATH}
  OPTIONS
    -DBUILD_TESTING=OFF
    -DBUILD_DOCUMENTATION=OFF
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
