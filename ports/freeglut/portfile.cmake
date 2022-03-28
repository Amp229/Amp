vcpkg_from_sourceforge(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO freeglut/freeglut
    REF 3.2.2
    FILENAME "freeglut-3.2.2.tar.gz"
    SHA512 190231951d314f854c244bd27f7c20488403bd0eecffc342097a2e3d1621cec87f6c209a77b4c153aabcf44697b4070227930e295ab74fb88953cbbf94fc81d9
    PATCHES 
        x11-dependencies-export.patch
        macOS_Xquartz.patch
        fix-debug-macro.patch
        no_x64_enforcement.patch
        windows-static-output-name.patch
)

if(NOT VCPKG_TARGET_IS_WINDOWS)
    message("Freeglut currently requires the following libraries from the system package manager:\n    opengl\n    glu\n    libx11\n    xrandr\n    xi\n    xxf86vm\n\nThese can be installed on Ubuntu systems via apt-get install libxi-dev libgl1-mesa-dev libglu1-mesa-dev mesa-common-dev libxrandr-dev libxxf86vm-dev\nOn macOS Xquartz is required.")
endif()

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" FREEGLUT_STATIC)
string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" FREEGLUT_DYNAMIC)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DFREEGLUT_BUILD_STATIC_LIBS=${FREEGLUT_STATIC}
        -DFREEGLUT_BUILD_SHARED_LIBS=${FREEGLUT_DYNAMIC}
        -DFREEGLUT_BUILD_DEMOS=OFF
        -DINSTALL_PDB=OFF # Installing pdbs failed on debug static. So, disable it and let vcpkg_copy_pdbs() do it
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/FreeGLUT)
vcpkg_fixup_pkgconfig()

# Rename static lib (otherwise it's incompatible with FindGLUT.cmake)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string(
        "${CURRENT_PACKAGES_DIR}/include/GL/freeglut_std.h"
        "ifdef FREEGLUT_STATIC"
        "if 1 //ifdef FREEGLUT_STATIC"
    )
endif()

# Clean
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/vcpkg-cmake-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/glut")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
