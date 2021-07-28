vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO curl/curl
    REF bfbde883af33397943df68a3ae01847a634d33bf #curl-7_78_0
    SHA512 72c2d0daedbd1e0610f507f637c5725cb0769befe5205f613260217b692e27ec135711974f85660f863a49b415c1457d2d29960158758e232caa89f972f7045e
    HEAD_REF master
    PATCHES
        0002_fix_uwp.patch
        0005_remove_imp_suffix.patch
        0006_fix_tool_depends.patch
        0007_disable_tool_export_curl_target.patch
        0010_fix_othertests_cmake.patch
        0011_fix_static_build.patch
        0012-fix-dependency-idn2.patch
        0020-fix-pc-file.patch
        0021-normaliz.patch # for mingw on case-sensitive file system
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" CURL_STATICLIB)

# schannel will enable sspi, but sspi do not support uwp
foreach(feature IN ITEMS "schannel" "sspi" "tool")
    if(feature IN_LIST FEATURES AND VCPKG_TARGET_IS_UWP)
        message(FATAL_ERROR "Feature ${feature} is not supported on UWP.")
    endif()
endforeach()

if("sectransp" IN_LIST FEATURES AND NOT VCPKG_TARGET_IS_OSX)
    message(FATAL_ERROR "sectransp is not supported on non-Apple platforms")
endif()

if("winidn" IN_LIST FEATURES AND NOT VCPKG_TARGET_IS_WINDOWS)
    message(FATAL_ERROR "Feature winidn is not supported on non-Windows platforms.")
endif()

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        # Support HTTP2 TLS Download https://curl.haxx.se/ca/cacert.pem rename to curl-ca-bundle.crt, copy it to libcurl.dll location.
        http2       USE_NGHTTP2
        openssl     CMAKE_USE_OPENSSL
        mbedtls     CMAKE_USE_MBEDTLS
        ssh         CMAKE_USE_LIBSSH2
        tool        BUILD_CURL_EXE
        c-ares      ENABLE_ARES
        sspi        CURL_WINDOWS_SSPI
        brotli      CURL_BROTLI
        schannel    CMAKE_USE_SCHANNEL
        sectransp   CMAKE_USE_SECTRANSP
        idn2        USE_LIBIDN2
        winidn      USE_WIN32_IDN

    INVERTED_FEATURES
        non-http    HTTP_ONLY
)

set(OPTIONS_RELEASE "")
set(OPTIONS_DEBUG "")
if("idn2" IN_LIST FEATURES)
    x_vcpkg_pkgconfig_get_modules(PREFIX libidn2 MODULES libidn2 LIBS)
    list(APPEND OPTIONS_RELEASE "-DLIBIDN2_LIBRARIES=${libidn2_LIBS_RELEASE}")
    list(APPEND OPTIONS_DEBUG   "-DLIBIDN2_LIBRARIES=${libidn2_LIBS_DEBUG}")
endif()

set(SECTRANSP_OPTIONS "")
if("sectransp" IN_LIST FEATURES)
    set(SECTRANSP_OPTIONS -DCURL_CA_PATH=none)
endif()

# UWP targets
set(UWP_OPTIONS "")
if(VCPKG_TARGET_IS_UWP)
    set(UWP_OPTIONS
        -DUSE_WIN32_LDAP=OFF
        -DCURL_DISABLE_TELNET=ON
        -DENABLE_IPV6=OFF
        -DENABLE_UNIX_SOCKETS=OFF
    )
endif()

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS 
        ${FEATURE_OPTIONS}
        ${UWP_OPTIONS}
        ${SECTRANSP_OPTIONS}
        -DBUILD_TESTING=OFF
        -DENABLE_MANUAL=OFF
        -DCURL_STATICLIB=${CURL_STATICLIB}
        -DCMAKE_DISABLE_FIND_PACKAGE_Perl=ON
        -DENABLE_DEBUG=ON
        -DCURL_CA_FALLBACK=ON
    OPTIONS_RELEASE
        ${OPTIONS_RELEASE}
    OPTIONS_DEBUG
        ${OPTIONS_DEBUG}
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()

if ("tool" IN_LIST FEATURES)
    vcpkg_copy_tools(TOOL_NAMES curl AUTO_CLEAN)
endif()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/CURL)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#Fix install path
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/bin/curl-config" "${CURRENT_PACKAGES_DIR}" "\${prefix}")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/bin/curl-config" "${CURRENT_INSTALLED_DIR}" "\${prefix}")
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/bin/curl-config" "\nprefix=\${prefix}" [=[prefix=$(CDPATH= cd -- "$(dirname -- "$0")"/../../.. && pwd -P)]=])
file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin")
file(RENAME "${CURRENT_PACKAGES_DIR}/bin/curl-config" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/curl-config")
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/bin/curl-config")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "${CURRENT_PACKAGES_DIR}" "\${prefix}")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "${CURRENT_INSTALLED_DIR}" "\${prefix}")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "\nprefix=\${prefix}/debug" [=[prefix=$(CDPATH= cd -- "$(dirname -- "$0")"/../../../.. && pwd -P)]=])
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "-lcurl" "-lcurl-d")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "curl." "curl-d.")
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/tools/${PORT}/debug/bin")
    file(RENAME "${CURRENT_PACKAGES_DIR}/debug/bin/curl-config" "${CURRENT_PACKAGES_DIR}/tools/${PORT}/debug/bin/curl-config")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static" OR NOT VCPKG_TARGET_IS_WINDOWS)
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/curl/curl.h"
        "#ifdef CURL_STATICLIB"
        "#if 1"
    )
endif()

vcpkg_fixup_pkgconfig()
if(EXISTS "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libcurl.pc")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/libcurl.pc" " -lcurl" " -lcurl-d")
endif()

file(INSTALL "${CURRENT_PORT_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
