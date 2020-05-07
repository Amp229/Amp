# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/python
    REF boost-1.73.0
    SHA512 de3523e39814ab6d1bfd69e77983e31f43be16e57c2ad2fe0ff5b67bfcc03ed35ee90a0365acd62c05640e25de223e2885401d03fce62cde47ba3329ada6f495
    HEAD_REF master
)

# Find Python3 executable
vcpkg_find_acquire_program(PYTHON3)
set(VCPKG_PYTHON_EXECUTABLE "${PYTHON3}")
# Find Python3 libraries. Can't use find_package here, but we already know where everything is
file(GLOB VCPKG_PYTHON_INCLUDE "${CURRENT_INSTALLED_DIR}/include/python3.*")
set(VCPKG_PYTHON_LIBS_RELEASE "${CURRENT_INSTALLED_DIR}/lib")
set(VCPKG_PYTHON_LIBS_DEBUG "${CURRENT_INSTALLED_DIR}/debug/lib")
string(REGEX REPLACE ".*python([0-9\.]+).*" "\\1" VCPKG_PYTHON_VERSION "${VCPKG_PYTHON_INCLUDE}")
include(${CURRENT_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
