# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/nowide
    REF boost-1.77.0
    SHA512 7af7a33aed8a8e88d8da37db302bb2d560e71dad57e2be23086dfca5260fb7b15ab4513807c566e91b3ebe27b10d58614e967895b922bc408c774550625d15cf
    HEAD_REF master
)

file(READ "${SOURCE_PATH}/build/Jamfile.v2" _contents)
string(REPLACE "import ../../config/checks/config" "import config/checks/config" _contents "${_contents}")
string(REPLACE "check-target-builds ../config//cxx11_moveable_fstreams" "check-target-builds ../check_movable_fstreams.cpp" _contents "${_contents}")
string(REPLACE "check-target-builds ../config//lfs_support" "check-target-builds ../check_lfs_support.cpp" _contents "${_contents}")
file(WRITE "${SOURCE_PATH}/build/Jamfile.v2" "${_contents}")
file(COPY "${CURRENT_INSTALLED_DIR}/share/boost-config/checks" DESTINATION "${SOURCE_PATH}/build/config")
file(COPY "${SOURCE_PATH}/config/check_lfs_support.cpp" "${SOURCE_PATH}/config/check_movable_fstreams.cpp" DESTINATION "${SOURCE_PATH}/build/config")
if(NOT DEFINED CURRENT_HOST_INSTALLED_DIR)
    message(FATAL_ERROR "boost-nowide requires a newer version of vcpkg in order to build.")
endif()
include(${CURRENT_HOST_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(
    SOURCE_PATH ${SOURCE_PATH}
    BOOST_CMAKE_FRAGMENT "${CMAKE_CURRENT_LIST_DIR}/b2-options.cmake"
)
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
