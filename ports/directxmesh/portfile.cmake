vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/DirectXMesh
    REF aug2020
    SHA512 4a116b6266070a075aca523d9439eeab878b5406ffe5f94f7c008d659842750eab17b11c027c7f1da1ed12a0b8a43ab53dc5aaea8477a0bb029654cd477b5424
    HEAD_REF master
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    INVERTED_FEATURES win7 BUILD_DX12
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS ${FEATURE_OPTIONS}
)

if(NOT VCPKG_TARGET_IS_UWP AND NOT TRIPLET_SYSTEM_ARCH STREQUAL "arm64")
    vcpkg_build_cmake()
else()
    vcpkg_build_cmake(TARGET DirectXMesh)
endif()

file(INSTALL ${SOURCE_PATH}/DirectXMesh/DirectXMesh.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/DirectXMesh/DirectXMesh.inl DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/bin/CMake/Debug/DirectXMesh.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bin/CMake/Release/DirectXMesh.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
if(NOT VCPKG_TARGET_IS_UWP AND NOT TRIPLET_SYSTEM_ARCH STREQUAL "arm64")
  vcpkg_copy_tools(
        TOOL_NAMES Meshconvert
        SEARCH_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bin/CMake/Release
    )
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
