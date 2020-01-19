# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/unordered
    REF boost-1.72.0
    SHA512 ad41c43e5eb82a57b3d2b21aa794a84c6241c7e3078eb6cd331910c6402eca1ddb46d687aefe80d67cde72711853516e7367ebe61d7af7d903d158c9c57ad891
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
