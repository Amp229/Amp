set(VERSION 2.0.0)

vcpkg_from_github(OUT_SOURCE_PATH SOURCE_PATH
    REPO DragonJoker/ShaderWriter
    REF 060694e3894ebd407063d279845835968654052b
    HEAD_REF master
    SHA512 34b8f324dbbdced72784c7b5095a5f24fa64abef8ab3bdcf389a43e66cfb5a9320204fbf8e20682c760969f50aa40704543162f6932469c0585a17279dddb5f0
)

vcpkg_from_github(OUT_SOURCE_PATH CMAKE_SOURCE_PATH
    REPO DragonJoker/CMakeUtils
    REF 5b4d86b3d203593c00c64a48c754afa5e2f3d267
    HEAD_REF master
    SHA512 8f51e514934e78b6b8763916be478ef47a9927e8d227b58aa456698243d263656b8b6811a47d42f2e9171e78b8aedd07ecd7b4c4577f1f08e63cf61a61cfb07e
)

get_filename_component(SRC_PATH ${CMAKE_SOURCE_PATH} DIRECTORY)
if (EXISTS ${SRC_PATH}/CMake)
    file(REMOVE_RECURSE ${SRC_PATH}/CMake)
endif()
file(RENAME ${CMAKE_SOURCE_PATH} ${SRC_PATH}/CMake)
set(CMAKE_SOURCE_PATH ${SRC_PATH}/CMake)
file(COPY ${CMAKE_SOURCE_PATH} DESTINATION ${SOURCE_PATH})

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "static" BUILD_STATIC)

vcpkg_cmake_configure(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DPROJECTS_USE_PRECOMPILED_HEADERS=OFF
        -DSDW_GENERATE_SOURCE=OFF
        -DSDW_BUILD_VULKAN_LAYER=OFF
        -DSDW_BUILD_TESTS=OFF
        -DSDW_BUILD_STATIC_SDW=${BUILD_STATIC}
        -DSDW_BUILD_STATIC_SDAST=${BUILD_STATIC}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/shaderwriter)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)