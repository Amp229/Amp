include(vcpkg_common_functions)

if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
	set(SYSTEM_PLATFORM "32")
	set(SYSTEM_PLATFORM_PATH "x86_32")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
	set(SYSTEM_PLATFORM "64")
	set(SYSTEM_PLATFORM_PATH "x86_64")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
	set(SYSTEM_PLATFORM "arm32")
	set(SYSTEM_PLATFORM_PATH "arm_32")
elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
	set(SYSTEM_PLATFORM "arm64")
	set(SYSTEM_PLATFORM_PATH "arm_64")
else()
    message(FATAL_ERROR "Unsupported architecture: ${VCPKG_TARGET_ARCHITECTURE}")
endif()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
	set(GENERATE_STATIC_LIBRARIES "True")
elseif(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    set(GENERATE_STATIC_LIBRARIES "False")
endif()

if("${VCPKG_CMAKE_SYSTEM_NAME}" STREQUAL "" OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
	if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
		set(MSBUILD_PLATFORM "Win32")
	elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
		set(MSBUILD_PLATFORM "x64")
	elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
		if(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm")
			set(MSBUILD_PLATFORM "ARM")
		elseif(VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
			set(MSBUILD_PLATFORM "ARM64")
		else()
    		message(FATAL_ERROR "Unsupported UWP architecture: ${VCPKG_TARGET_ARCHITECTURE}")
		endif()
	else()
    	message(FATAL_ERROR "Unsupported Windows architecture: ${VCPKG_TARGET_ARCHITECTURE}")
	endif()

	if(VCPKG_PLATFORM_TOOLSET STREQUAL "v140")
		set(MSVC_VERSION "14")
		set(TOOLSET_VERSION "140")
	elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v141")
		set(MSVC_VERSION "15")
		set(TOOLSET_VERSION "141")
	elseif(VCPKG_PLATFORM_TOOLSET STREQUAL "v142")
		set(MSVC_VERSION "16")
		set(TOOLSET_VERSION "142")
	else()
		message(FATAL_ERROR "Unsupported platform toolset.")
	endif()

	set(FLOAT_POINT_PRECISE_MATH "False")
	set(BUILD_SNIPPETS "False")
	set(BUILD_PUBLIC_SAMPLES "False")

	if("${VCPKG_CMAKE_SYSTEM_NAME}" STREQUAL "")
		set(SYSTEM "win")
		if(VCPKG_CRT_LINKAGE STREQUAL "dynamic")
			set(USE_STATIC_WINCRT "False")
			set(RUNTIME_LIBRARY_LINKAGE "md")
		elseif(VCPKG_CRT_LINKAGE STREQUAL "static")
			set(USE_STATIC_WINCRT "True")
			set(RUNTIME_LIBRARY_LINKAGE "mt")
		endif()
		set(USE_DEBUG_CRT "True")
		set(COMPILER "vc${MSVC_VERSION}${SYSTEM}${SYSTEM_PLATFORM}")
		set(PRESET_FILE ${COMPILER}-${RUNTIME_LIBRARY_LINKAGE}-${VCPKG_LIBRARY_LINKAGE})
		set(BUILD_PATH "${SYSTEM}.${SYSTEM_PLATFORM_PATH}.vc${TOOLSET_VERSION}.${RUNTIME_LIBRARY_LINKAGE}")
	elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
		set(SYSTEM "uwp")
		set(USE_STATIC_WINCRT "False")
		set(USE_DEBUG_CRT "False")
		set(COMPILER "vc${MSVC_VERSION}${SYSTEM}${SYSTEM_PLATFORM}")
		set(PRESET_FILE ${COMPILER}-${VCPKG_LIBRARY_LINKAGE})
		set(BUILD_PATH "${SYSTEM}.${SYSTEM_PLATFORM_PATH}.vc${TOOLSET_VERSION}")
	endif()
else()
	message(FATAL_ERROR "Unsupported platform: ${VCPKG_CMAKE_SYSTEM_NAME}")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIAGameWorks/PhysX
    REF ae80dede0546d652040ae6260a810e53e20a06fa
    SHA512 f3a690039cf39fe2db9a728b82af0d39eaa02340a853bdad4b5152d63532367eb24fc7033a614882168049b80d803b6225fc60ed2900a9d0deab847f220540be
    HEAD_REF master
	PATCHES
		msvc_142_bug_workaround.patch
		vs16_3_typeinfo_header_fix.patch
)

file(REMOVE ${SOURCE_PATH}/physx/buildtools/presets/public/${PRESET_FILE}.xml)
configure_file(${CMAKE_CURRENT_LIST_DIR}/preset.xml.in ${SOURCE_PATH}/physx/buildtools/presets/public/${PRESET_FILE}.xml)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR ${PYTHON3} DIRECTORY)
vcpkg_add_to_path(${PYTHON3_DIR})

get_filename_component(CMAKE_DIR ${CMAKE_COMMAND} DIRECTORY)
# If cmake is not installed then adding it to the end of the path
# will allow generate_projects.bat to find the cmake used by vcpkg.
vcpkg_add_to_path(${CMAKE_DIR})

vcpkg_execute_required_process( 
	COMMAND ${SOURCE_PATH}/physx/generate_projects.bat ${PRESET_FILE}
	WORKING_DIRECTORY ${SOURCE_PATH}/physx
	LOGNAME build-${TARGET_TRIPLET}
)

set(RELEASE_CONFIGURATION "release")
set(DEBUG_CONFIGURATION "debug")

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/physx/compiler/${COMPILER}/PhysXSDK.sln
	RELEASE_CONFIGURATION ${RELEASE_CONFIGURATION}
	DEBUG_CONFIGURATION ${DEBUG_CONFIGURATION}
    PLATFORM ${MSBUILD_PLATFORM}
)

file(INSTALL ${SOURCE_PATH}/physx/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT}/)
file(INSTALL ${SOURCE_PATH}/pxshared/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/${PORT}/)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
	file(GLOB RELEASE_BINS ${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${RELEASE_CONFIGURATION}/*.dll)
	file(INSTALL ${RELEASE_BINS} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)

	file(GLOB DEBUG_BINS ${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${DEBUG_CONFIGURATION}/*.dll)
	file(INSTALL ${DEBUG_BINS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

	vcpkg_copy_pdbs()
endif()

file(
	GLOB
	RELEASE_LIBS
		${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${RELEASE_CONFIGURATION}/*.lib
		${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${RELEASE_CONFIGURATION}/*.pdb
		${SOURCE_PATH}/physx/compiler/${COMPILER}/sdk_source_bin/${RELEASE_CONFIGURATION}/*.pdb
)
file(INSTALL ${RELEASE_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

file(
	GLOB
	DEBUG_LIBS
	${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${DEBUG_CONFIGURATION}/*.lib
	${SOURCE_PATH}/physx/bin/${BUILD_PATH}/${DEBUG_CONFIGURATION}/*.pdb
	${SOURCE_PATH}/physx/compiler/${COMPILER}/sdk_source_bin/${DEBUG_CONFIGURATION}/*.pdb
)
file(INSTALL ${DEBUG_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(INSTALL ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
