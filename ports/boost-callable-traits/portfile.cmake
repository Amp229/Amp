# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/callable_traits
    REF boost-1.83.0
    SHA512 102097394e795dea433742941c5708c2bd80c1a59fb2d4acb851ec071822f505889ca3fa8484332e684d210d16820212519674d1a758463258ae6fef6634e0e9
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
