include(vcpkg_common_functions)

if (EXISTS "${CURRENT_BUILDTREES_DIR}/src/.git")
    file(REMOVE_RECURSE ${CURRENT_BUILDTREES_DIR}/src)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/googletest
    REF release-1.8.1
    SHA512 e6283c667558e1fd6e49fa96e52af0e415a3c8037afe1d28b7ff1ec4c2ef8f49beb70a9327b7fc77eb4052a58c4ccad8b5260ec90e4bceeac7a46ff59c4369d7
    HEAD_REF master
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/0002-Fix-z7-override.patch
)

string(COMPARE EQUAL "${VCPKG_CRT_LINKAGE}" "dynamic" GTEST_FORCE_SHARED_CRT)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_GMOCK=ON
        -DBUILD_GTEST=ON
        -DCMAKE_DEBUG_POSTFIX=d
        -Dgtest_force_shared_crt=${GTEST_FORCE_SHARED_CRT}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/GTest)

file(
    INSTALL
        "${SOURCE_PATH}/googletest/src/gtest.cc"
        "${SOURCE_PATH}/googletest/src/gtest_main.cc"
        "${SOURCE_PATH}/googletest/src/gtest-all.cc"
        "${SOURCE_PATH}/googletest/src/gtest-death-test.cc"
        "${SOURCE_PATH}/googletest/src/gtest-filepath.cc"
        "${SOURCE_PATH}/googletest/src/gtest-internal-inl.h"
        "${SOURCE_PATH}/googletest/src/gtest-port.cc"
        "${SOURCE_PATH}/googletest/src/gtest-printers.cc"
        "${SOURCE_PATH}/googletest/src/gtest-test-part.cc"
        "${SOURCE_PATH}/googletest/src/gtest-typed-test.cc"
    DESTINATION
        ${CURRENT_PACKAGES_DIR}/src
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/googletest/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/gtest RENAME copyright)

if(EXISTS ${CURRENT_PACKAGES_DIR}/debug/lib/gtest_maind.lib)
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link)
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/gtest_maind.lib ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link/gtest_maind.lib)
    file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/gmock_maind.lib ${CURRENT_PACKAGES_DIR}/debug/lib/manual-link/gmock_maind.lib)

    file(READ ${CURRENT_PACKAGES_DIR}/share/gtest/GTestTargets-debug.cmake DEBUG_CONFIG)
    string(REPLACE "\${_IMPORT_PREFIX}/debug/lib/gtest_maind.lib"
                   "\${_IMPORT_PREFIX}/debug/lib/manual-link/gtest_maind.lib" DEBUG_CONFIG "${DEBUG_CONFIG}")
    string(REPLACE "\${_IMPORT_PREFIX}/debug/lib/gmock_maind.lib"
                   "\${_IMPORT_PREFIX}/debug/lib/manual-link/gmock_maind.lib" DEBUG_CONFIG "${DEBUG_CONFIG}")
    file(WRITE ${CURRENT_PACKAGES_DIR}/share/gtest/GTestTargets-debug.cmake "${DEBUG_CONFIG}")
endif()

if(EXISTS ${CURRENT_PACKAGES_DIR}/lib/gtest_main.lib)
    file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/lib/manual-link)
    file(RENAME ${CURRENT_PACKAGES_DIR}/lib/gtest_main.lib ${CURRENT_PACKAGES_DIR}/lib/manual-link/gtest_main.lib)
    file(RENAME ${CURRENT_PACKAGES_DIR}/lib/gmock_main.lib ${CURRENT_PACKAGES_DIR}/lib/manual-link/gmock_main.lib)

    file(READ ${CURRENT_PACKAGES_DIR}/share/gtest/GTestTargets-release.cmake RELEASE_CONFIG)
    string(REPLACE "\${_IMPORT_PREFIX}/lib/gtest_main.lib"
                   "\${_IMPORT_PREFIX}/manual-link/gtest_main.lib" RELEASE_CONFIG "${RELEASE_CONFIG}")
    string(REPLACE "\${_IMPORT_PREFIX}/lib/gmock_main.lib"
                   "\${_IMPORT_PREFIX}/manual-link/gmock_main.lib" RELEASE_CONFIG "${RELEASE_CONFIG}")
    file(WRITE ${CURRENT_PACKAGES_DIR}/share/gtest/GTestTargets-release.cmake "${RELEASE_CONFIG}")
endif()

vcpkg_copy_pdbs()

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
