include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)

if (VCPKG_TARGET_ARCHITECTURE MATCHES "x86")
    set(WIN32_INCLUDE_STDDEF "x86-windows-include-stddef.patch")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ismrmrd/ismrmrd
    REF 4d4004d91ccadd41ddb30b019f970a69bb23a1bc
    SHA512 71c8e073fb5a0b18e552a950b90d6ab03e0f28aad126d6f311b4c75c36d023398c84419142668d6deddbe97bdfedb5a8e30851730c2de7aae8f914e1f0d443be 
    HEAD_REF master
    PATCHES
        ${WIN32_INCLUDE_STDDEF}
)



vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_HDF5_DATASET_SUPPORT=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/ismrmrd/cmake)

if(EXISTS ${CURRENT_PACKAGES_DIR}/lib/ismrmrd.dll)
    file(COPY ${CURRENT_PACKAGES_DIR}/lib/ismrmrd.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/ismrmrd.dll)
endif()

if(EXISTS ${CURRENT_PACKAGES_DIR}/debug/lib/ismrmrd.dll)
    file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/ismrmrd.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/ismrmrd.dll)
endif()


file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/FindFFTW3.cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/FindFFTW3.cmake)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share/ismrmrd/FindFFTW3.cmake)

file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/share/ismrmrd/cmake)

set(ISMRMRD_CMAKE_DIRS ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/debug/lib/cmake)
foreach(ISMRMRD_CMAKE_DIR IN LISTS ISMRMRD_CMAKE_DIRS)
if (EXISTS ${ISMRMRD_CMAKE_DIR})
    file(GLOB ISMRMRD_CMAKE_FILES "${ISMRMRD_CMAKE_DIR}/ISMRMRD/ISMRMRD*.cmake")
    foreach(ICF ${ISMRMRD_CMAKE_FILES})
        file(COPY ${ICF} DESTINATION ${CURRENT_PACKAGES_DIR}/share/ismrmrd/cmake/)
    endforeach()
endif()
endforeach()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${ISMRMRD_CMAKE_DIRS})


file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/ismrmrd_info.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/ismrmrd_info.exe)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/ismrmrd_c_example.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/ismrmrd_c_example.exe)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin/ismrmrd_read_timing_test.exe)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/ismrmrd_read_timing_test.exe)

file(COPY ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ismrmrd)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ismrmrd/LICENSE ${CURRENT_PACKAGES_DIR}/share/ismrmrd/copyright)

vcpkg_copy_tool_dependencies(${CURRENT_PACKAGES_DIR}/tools/ismrmrd)
