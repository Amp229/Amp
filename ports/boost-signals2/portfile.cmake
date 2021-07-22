# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/signals2
    REF boost-1.76.0
    SHA512 d298a325c35dc0eda9614b6e8a4e84e7ef240e83e2b5938bc521ac99e5095c13b7a4e6a48b1b30bf1c038dd4c3e43d23dd85c14473da942cf65c5723fbb1c954
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
