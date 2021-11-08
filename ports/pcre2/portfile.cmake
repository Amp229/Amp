vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO PhilipHazel/pcre2
    REF 35fee4193b852cb504892352bd0155de10809889 # pcre2-10.39
    SHA512 a6e50f3354dc4172df05e887dd8646d4ce6a3584fe180b17dc27b42b094e13d1d1a7e5ab3cb15dd352764d81ac33cfd03e81b0c890d9ddec72d823ca6f8bd667
    HEAD_REF master
    PATCHES
        pcre2-10.35_fix-uwp.patch
)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Emscripten" OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "iOS")
    set(JIT OFF)
else()
    set(JIT ON)
endif()

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}

    OPTIONS
        -DPCRE2_BUILD_PCRE2_8=ON
        -DPCRE2_BUILD_PCRE2_16=ON
        -DPCRE2_BUILD_PCRE2_32=ON
        -DPCRE2_SUPPORT_JIT=${JIT}
        -DPCRE2_SUPPORT_UNICODE=ON
        -DPCRE2_BUILD_TESTS=OFF
        -DPCRE2_BUILD_PCRE2GREP=OFF
)

vcpkg_cmake_install()

file(READ ${CURRENT_PACKAGES_DIR}/include/pcre2.h PCRE2_H)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    string(REPLACE "defined(PCRE2_STATIC)" "1" PCRE2_H "${PCRE2_H}")
else()
    string(REPLACE "defined(PCRE2_STATIC)" "0" PCRE2_H "${PCRE2_H}")
endif()
file(WRITE ${CURRENT_PACKAGES_DIR}/include/pcre2.h "${PCRE2_H}")

vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(CONFIG_PATH cmake)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/man)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/doc)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/man)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
