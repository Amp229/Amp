set(OATPP_VERSION "1.0.0")

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO oatpp/oatpp
    REF 5a9f042a78e7a47d1788407c99f6257fc7b40fa9 # 1.0.0
    SHA512 133f69e43608b3b5eda929952c8fb49f08bbc114d75b326293a7ddf5f40b7b94ffcff7df2d999c91195ba9939166143ad173b27a962f4fb661f731f63a44116e
    HEAD_REF master
)

set(ENV{CL} "-D_CRT_SECURE_NO_WARNINGS")

vcpkg_configure_cmake(
    SOURCE_PATH "${SOURCE_PATH}"
    PREFER_NINJA
    OPTIONS
        "-DOATPP_BUILD_TESTS:BOOL=OFF"
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/oatpp-${OATPP_VERSION})
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
