vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO an-tao/trantor
    REF v1.0.0-rc13
    SHA512 a2670944a435d5bebee5fc9f14c09aa00d1c86375207c8122d2490ea0636d535a33006ae61d532f503cf877f3d9eb6cfbbf326828e02e29a321212bad2b1606f
    HEAD_REF master
)

# if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
#     set(TRANTOR_SHARED OFF)
# else()
#     set(TRANTOR_SHARED ON)
# endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    # OPTIONS 
    #     -DBUILD_TRANTOR_SHARED=${TRANTOR_SHARED}
)

vcpkg_install_cmake()

# Fix CMake files
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/Trantor)

# # Remove includes in debug
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
# Handle copyright
file(COPY ${SOURCE_PATH}/License DESTINATION ${CURRENT_PACKAGES_DIR}/share/trantor)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/trantor/License ${CURRENT_PACKAGES_DIR}/share/trantor/copyright)

# Copy pdb files
vcpkg_copy_pdbs()
