vcpkg_fail_port_install(ON_TARGET "UWP")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libarchive/libarchive
    REF fc6563f5130d8a7ee1fc27c0e55baef35119f26c   #v3.4.3
    SHA512 54ca4f3cc3b38dcf6588b2369ce43109c4a57a04061348ab8bf046c5c13ace0c4f42c9f3961288542cb5fe12c05359d572b39fe7cec32a10151dbac78e8a3707
    HEAD_REF master
    PATCHES
        fix-buildsystem.patch
        fix-dependencies.patch
        fix-cpu-set.patch
        disable-warnings.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    bzip2   ENABLE_BZip2
    libxml2 ENABLE_LIBXML2
    lz4     ENABLE_LZ4
    lzma    ENABLE_LZMA
    lzo     ENABLE_LZO
    openssl ENABLE_OPENSSL
    zstd    ENABLE_ZSTD
    # The below features should be added to CONTROL
    #pcre    ENABLE_PCREPOSIX
    #nettle  ENABLE_NETTLE
    #expat   ENABLE_EXPAT
    #libgcc  ENABLE_LibGCC
    #cng     ENABLE_CNG
    #tar     ENABLE_TAR # Tool build option?
    #cpio    ENABLE_CPIO # Tool build option?
    #cat     ENABLE_CAT # Tool build option?
    #xattr   ENABLE_XATTR # Tool support option?
    #acl     ENABLE_ACL # Tool support option?
    #iconv   ENABLE_ICONV # iconv support option?
    #libb2   ENABLE_LIBB2
)

if(FEATURES MATCHES "pcre")
else()
    list(APPEND FEATURE_OPTIONS -DPOSIX_REGEX_LIB=NONE)
endif()

list(APPEND FEATURE_OPTIONS -DENABLE_ZLIB=ON)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        ${FEATURE_OPTIONS}
        -DENABLE_PCREPOSIX=OFF
        -DENABLE_NETTLE=OFF
        -DENABLE_EXPAT=OFF
        -DENABLE_LibGCC=OFF
        -DENABLE_CNG=OFF
        -DENABLE_TAR=OFF
        -DENABLE_CPIO=OFF
        -DENABLE_CAT=OFF
        -DENABLE_XATTR=OFF
        -DENABLE_ACL=OFF
        -DENABLE_ICONV=OFF
        -DENABLE_TEST=OFF
        -DENABLE_WERROR=OFF
)

vcpkg_install_cmake()

set(LIBARCHIVE_CONFIG "include(CMakeFindDependencyMacro)\n")
if(FEATURES MATCHES "lz4")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(lz4)\n")
endif()
if(FEATURES MATCHES "lzma")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(LibLZMA)\n")
endif()
if(FEATURES MATCHES "zstd")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(zstd)\n")
endif()
if(FEATURES MATCHES "bzip2")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(BZip2)\n")
endif()
if(FEATURES MATCHES "libxml2")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(LibXml2)\n")
endif()
if(FEATURES MATCHES "openssl")
    set(LIBARCHIVE_CONFIG "${LIBARCHIVE_CONFIG}find_dependency(OpenSSL)\n")
endif()
file(WRITE ${CURRENT_PACKAGES_DIR}/share/libarchive/libarchiveConfig.cmake "${LIBARCHIVE_CONFIG}")

vcpkg_copy_pdbs()

foreach(_feature IN LISTS FEATURE_OPTIONS)
    string(REPLACE "-D" "" _feature "${_feature}")
    string(REPLACE "=" ";" _feature "${_feature}")
    string(REPLACE "ON" "1" _feature "${_feature}")
    string(REPLACE "OFF" "0" _feature "${_feature}")
    list(GET _feature 0 _feature_name)
    list(GET _feature 1 _feature_status)
    set(${_feature_name} ${_feature_status})
endforeach()
configure_file("${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" "${CURRENT_PACKAGES_DIR}/share/${PORT}/vcpkg-cmake-wrapper.cmake" @ONLY)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
foreach(HEADER ${CURRENT_PACKAGES_DIR}/include/archive.h ${CURRENT_PACKAGES_DIR}/include/archive_entry.h)
    file(READ ${HEADER} CONTENTS)
    string(REPLACE "(!defined LIBARCHIVE_STATIC)" "0" CONTENTS "${CONTENTS}")
    file(WRITE ${HEADER} "${CONTENTS}")
endforeach()

file(INSTALL ${CURRENT_PORT_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
