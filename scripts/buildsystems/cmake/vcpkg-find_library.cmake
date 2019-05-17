# A word about find_library and vcpkg
# In single configuration generators vcpkg will fix CMAKE_PREFIX_PATH and other variables to correctly search for libraries
# In a multi configuration generator vcpkg there can only be one CMAKE_PREFIX_PATH so we have to correct all find_library calls
# If the library variable is called either _RELEASE or _DEBUG there must be a way to distingush between debug/release version of a library by name (so no change required here)

option(VCPKG_ONLY_VCPKG_LIBS "Disallows find_library calls to search outside of the vcpkg directory" OFF)
mark_as_advanced(VCPKG_ONLY_VCPKG_LIBS)

function(find_library _vcpkg_lib_var)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0054 NEW)
    set(_vcpkg_list_vars "${ARGV}")
    set(options NAMES_PER_DIR 
                NO_DEFAULT_PATH 
                NO_PACKAGE_ROOT_PATH 
                NO_CMAKE_PATH 
                NO_CMAKE_ENVIRONMENT_PATH 
                NO_SYSTEM_ENVIRONMENT_PATH 
                NO_CMAKE_SYSTEM_PATH
                CMAKE_FIND_ROOT_PATH_BOTH 
                ONLY_CMAKE_FIND_ROOT_PATH 
                NO_CMAKE_FIND_ROOT_PATH)
    set(oneValueArgs DOC)
    set(multiValueArgs NAMES 
                       HINTS
                       PATHS
                       PATH_SUFFIXES)
    cmake_parse_arguments(PARSE_ARGV 1 _vcpkg_find_lib "${options}" "${oneValueArgs}" "${multiValueArgs}")
    #cmake_parse_arguments(_vcpkg_find_lib "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    if(NOT DEFINED _vcpkg_find_lib_NAMES)
        set(_vcpkg_find_lib_NAMES ${ARGV1})
        set(_insert_offset 1)
    else()
        set(_insert_offset 2)
    endif()
    if(NOT _vcpkg_find_lib_NAMES_PER_DIR) #Insert NAMES_PER_DIR if not set!
        list(LENGTH _vcpkg_find_lib_NAMES _vcpkg_find_lib_NAMES_LENGTH)
        math(EXPR _insert_pos "${_vcpkg_find_lib_NAMES_LENGTH}+${_insert_offset}" OUTPUT_FORMAT DECIMAL)
        list(INSERT _vcpkg_list_vars ${_insert_pos} NAMES_PER_DIR)
        vcpkg_msg(STATUS "find_library" "Added NAMES_PER_DIR to find_library call at position ${_vcpkg_find_lib_NAMES_LENGTH}!")
    endif()
    vcpkg_msg(STATUS "find_library-vars" "${_vcpkg_list_vars}")
#    if(DEFINED CMAKE_CONFIGURATION_TYPES)
#        if("${_vcpkg_lib_var}" MATCHES "_DEBUG" OR "${_vcpkg_lib_var}" MATCHES "_RELEASE") 
        #Since /share is in CMAKE_PREFIX_PATH and _DEBUG and _RELEASE variables must 
        #have a way to distingush between the two configuration we can use PATH suffixes here.
        #suffixes are also used to not change the default search order too much
#            set(_REQUIRED_PATH_SUFFIXES "/../;/../debug;/../manual-link;/../debug/manual-link") # Order does not matter here since filenames must be different
#            if(_vcpkg_find_lib_PATH_SUFFIXES)
#                list(FIND _vcpkg_list_vars "PATH_SUFFIXES" _vcpkg_PATH_SUFFIXES_pos)
#                list(LENGTH _vcpkg_find_lib_PATH_SUFFIXES _vcpkg_find_lib_PATH_SUFFIXES_LENGTH)
#                math(EXPR _insert_position "${_vcpkg_PATH_SUFFIXES_pos}+${_vcpkg_find_lib_PATH_SUFFIXES_LENGTH}" DECIMAL)
#                list(INSERT _vcpkg_list_vars ${_insert_position}"${_REQUIRED_PATH_SUFFIXES})
#            else()
#                list(APPEND _vcpkg_list_vars "PATH_SUFFIXES;${_REQUIRED_PATH_SUFFIXES}") # Lets try if simply appending is enough!
#            endif()
#        else()
#        endif()
#    endif()
    _find_library(${_vcpkg_list_vars})
    if(NOT "${${_vcpkg_lib_var}}" MATCHES "NOTFOUND") #Library was found
        message(STATUS "VCPKG-find_library: ${_vcpkg_lib_var}:${${_vcpkg_lib_var}}")
        if("${${_vcpkg_lib_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}") 
        #Check if within vcpkg folder/if not not our concern
        #This is the first barrier of defense against wrong configuration linkage
            if("${_vcpkg_lib_var}" MATCHES "_DEBUG")
                if(NOT "${${_vcpkg_lib_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib")
                    #This probably means that the find module assumes a wrong name for the debug library
                    cmake_policy(POP)
                    vcpkg_msg(FATAL_ERROR "find_library" "${_vcpkg_lib_var}:${${_vcpkg_lib_var}} does not point to debug directory! Check library debug naming! NAMES: ${_vcpkg_find_lib_NAMES}")
                endif()
            elseif("${_vcpkg_lib_var}" MATCHES "_RELEASE")
                if(NOT "${${_vcpkg_lib_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib")
                    #This probably means that debug name = release name so we search only in the release lib path!
                    vcpkg_msg(STATUS "find_library" "${_vcpkg_lib_var}:${${_vcpkg_lib_var}} does not point to release directory! This probably means that debug name = release name!: NAMES: ${_vcpkg_find_lib_NAMES}")
                    _find_library(_tmp_${_vcpkg_lib_var} NAMES ${_vcpkg_find_lib_NAMES} NAMES_PER_DIR PATHS "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib" NO_DEFAULT_PATH) 
                    set(_vcpkg_lib_var _tmp_${_vcpkg_lib_var} PARENT_SCOPE) #Cannot be directly set since CMake will CACHE the previous result
                    vcpkg_msg(STATUS "find_library" "${_vcpkg_lib_var} after ${${_vcpkg_lib_var}}")
                endif()
            else() #these are the cases we probably need to correct!
                if(NOT "${${_vcpkg_lib_var}}" MATCHES "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/")
                    cmake_policy(POP)
                    vcpkg_msg(FATAL_ERROR "find_library" "${_vcpkg_lib_var}:${${_vcpkg_lib_var}} does not point to debug directory as expected! \
                                                          Check library debug/release naming!: NAMES: ${_vcpkg_find_lib_NAMES}")
                else()
                    vcpkg_msg(STATUS "find_library" "${_vcpkg_lib_var} before ${${_vcpkg_lib_var}}")
                    string(REGEX REPLACE "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/" "${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/\$<\$<CONFIG:DEBUG>:debug/>" "${_vcpkg_lib_var}" "${${_vcpkg_lib_var}}")
                    set(_vcpkg_lib_var ${_vcpkg_lib_var} PARENT_SCOPE) #Need to promote change to parant scope
                    vcpkg_msg(STATUS "find_library" "${_vcpkg_lib_var} after ${${_vcpkg_lib_var}}")
                endif()
            endif()
        endif()
    else()
        vcpkg_msg(STATUS "find_library" "${_vcpkg_lib_var} was not found!")
    endif()
    cmake_policy(POP)
endfunction()