vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO owt5008137/libcopp
    REF 1.3.1
    SHA512 0401f91a98b5e3961bcda45a6249fec72f03c88ae5155f4406ba8922f47ccf187f65d6f13dedb6dcd6934bb6cb742a34e84a2fd29ca9cc5b87ca19a517a64591
    HEAD_REF v2
)

# Use libcopp's own build process, skipping examples and tests
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    DISABLE_PARALLEL_CONFIGURE
    # PREFER_NINJA # Disabled because Ninja does not invoke masm correctly for this project
)

vcpkg_install_cmake()

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/BOOST_LICENSE_1_0.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
