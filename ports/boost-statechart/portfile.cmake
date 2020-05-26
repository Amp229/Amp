# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/statechart
    REF boost-1.73.0
    SHA512 911a4fc91281506b8d002bc965e547a2a7a2e2ecbcb9241cad2eee7aa59b35738061c68d82e0dc7f9ee0a44941f2c3ac264582769068a7804a3b9b00745b9255
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
