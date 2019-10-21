# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/smart_ptr
    REF boost-1.71.0
    SHA512 74459b479ff30922f498ddd6d231ad7981b1836b8d80e0e584b151b643a8bcac54c60ed97a88a574f26d983467bb36d729dcce7bd361e7781fa21bec069d5c39
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
