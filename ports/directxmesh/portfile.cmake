vcpkg_check_linkage(ONLY_STATIC_LIBRARY ONLY_DYNAMIC_CRT)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Microsoft/DirectXMesh
    REF aug2020
    SHA512 4a116b6266070a075aca523d9439eeab878b5406ffe5f94f7c008d659842750eab17b11c027c7f1da1ed12a0b8a43ab53dc5aaea8477a0bb029654cd477b5424
    HEAD_REF master
)

if("dx12" IN_LIST FEATURES OR VCPKG_TARGET_IS_UWP OR TRIPLET_SYSTEM_ARCH STREQUAL "arm64")
    set(FEATURE_OPTIONS -DBUILD_DX12=ON)
else()
    set(FEATURE_OPTIONS -DBUILD_DX12=OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS ${FEATURE_OPTIONS}
)

if(NOT VCPKG_TARGET_IS_UWP AND NOT TRIPLET_SYSTEM_ARCH STREQUAL "arm64")
    vcpkg_build_cmake()
else()
    vcpkg_build_cmake(TARGET DirectXMesh)
endif()

file(INSTALL ${SOURCE_PATH}/DirectXMesh/DirectXMesh.h DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/DirectXMesh/DirectXMesh.inl DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(GLOB_RECURSE DEBUG_LIB ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/bin/CMake/*.lib)
file(GLOB_RECURSE RELEASE_LIB ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bin/CMake/*.lib)
file(INSTALL ${DEBUG_LIB} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(INSTALL ${RELEASE_LIB} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
if(NOT VCPKG_TARGET_IS_UWP AND NOT TRIPLET_SYSTEM_ARCH STREQUAL "arm64")
  vcpkg_copy_tools(
        TOOL_NAMES Meshconvert
        SEARCH_DIR ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/bin/CMake
    )
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
