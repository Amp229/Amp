vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rioki/libxmlmm
    REF r0.6
    SHA512 4f619e730de2f88b891ef31dd7ced2e6be75fff7f3852ec178843bf8d099d2e1ea84e0fcde35ff7fefc201b026f63e4b5d55f88e48334c49a0333be0327894df
    HEAD_REF master
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL "${SOURCE_PATH}/README.md" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
