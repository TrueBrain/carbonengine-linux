vcpkg_from_git(
  OUT_SOURCE_PATH SOURCE_PATH
  URL git@github.com:carbonengine/trinity.git
  REF 4675ceaaa445f7fd44a1dc97472c8efa4ad8599c
  PATCHES
    # BEGIN EXPORTED PATCHES (managed by export-port-patches.sh)
0001-build-update-vcpkg-registry-to-HTTPS.patch
0002-chore-update-CMakePresets-to-be-more-like-the-rest.patch
0003-build-integrate-vcpkg-manifest-features.patch
0004-fix-spurious-spaces-in-TRINITY_AL_PLATFORM_INCLUDE.patch
0005-fix-memset-on-non-trivial-objects-errors.patch
0006-fix-compile-on-case-sensitive-filesystems.patch
0007-fix-compile-errors-when-including-regex.patch
0008-chore-include-all-required-system-headers.patch
0009-chore-remove-dangling-at-end-of-comment.patch
0010-chore-remove-MSVC-ism-from-std-functions.patch
0011-chore-cast-XMVector-to-Vector-properly.patch
0012-fix-adding-a-Vector3-to-a-Vector4-has-no-resolution.patch
0013-port-shadercompiler-add-support-for-Linux.patch
0014-port-add-basic-support-for-Linux.patch
0015-port-trinityal-add-Vulkan-backend-for-Linux.patch
0016-port-trinity-add-X11-support-for-Linux.patch
0017-port-trinity-add-Vulkan-backend-for-shadercompiler.patch
    # END EXPORTED PATCHES
)

# Setup the features
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        shader-compiler         BUILD_SHADER_COMPILER
        dx11                    BUILD_DX11
        dx12                    BUILD_DX12
        metal                   BUILD_METAL
        vulkan                  BUILD_VULKAN
        with-granny             WITH_GRANNY
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
