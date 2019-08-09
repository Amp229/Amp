vcpkg_define_function_overwrite_option(target_link_libraries)

function(vcpkg_target_link_libraries _target_name)

  #get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
  #if( _CMAKE_IN_TRY_COMPILE )
  #	 _target_link_libraries(${ARGV})
#	 return()
 # endif()
  
  vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links: ${ARGN}")

  cmake_parse_arguments(PARSE_ARGV 1 _vcpkg_tll "" "" "PRIVATE;PUBLIC;INTERFACE;LINK_PRIVATE;LINK_PUBLIC;LINK_INTERFACE_LIBRARIES")
  
  if(DEFINED _vcpkg_tll_PRIVATE)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links private: ${_vcpkg_tll_PRIVATE}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_PRIVATE})
    _target_link_libraries(${_target_name} PRIVATE ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  if(DEFINED _vcpkg_tll_PUBLIC)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links public: ${_vcpkg_tll_PUBLIC}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_PUBLIC})
    _target_link_libraries(${_target_name} PUBLIC ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  if(DEFINED _vcpkg_tll_INTERFACE)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links interface: ${_vcpkg_tll_INTERFACE}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_INTERFACE})
    _target_link_libraries(${_target_name} INTERFACE ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  #Deprecated link styles
  if(DEFINED _vcpkg_tll_LINK_PRIVATE)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links private: ${_vcpkg_tll_LINK_PRIVATE}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_LINK_PRIVATE})
    _target_link_libraries(${_target_name} LINK_PRIVATE ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  if(DEFINED _vcpkg_tll_LINK_PUBLIC)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links public: ${_vcpkg_tll_LINK_PUBLIC}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_LINK_PUBLIC})
    _target_link_libraries(${_target_name} LINK_PUBLIC ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  if(DEFINED _vcpkg_tll_LINK_INTERFACE_LIBRARIES)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links interface: ${_vcpkg_tll_LINK_INTERFACE_LIBRARIES}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_LINK_INTERFACE_LIBRARIES})
    _target_link_libraries(${_target_name} LINK_INTERFACE_LIBRARIES ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
  if(DEFINED _vcpkg_tll_UNPARSED_ARGUMENTS)
    vcpkg_msg(STATUS "vcpkg_target_link_libraries" "Target ${_target_name} links unparsed: ${_vcpkg_tll_UNPARSED_ARGUMENTS}")
    vcpkg_check_linkage(_vcpkg_check_linkage ${_vcpkg_tll_UNPARSED_ARGUMENTS})
    _target_link_libraries(${_target_name} ${_vcpkg_check_linkage})
    unset(_vcpkg_check_linkage)
  endif()
endfunction()

if(VCPKG_ENABLE_target_link_libraries)
    function(target_link_libraries)
        vcpkg_enable_function_overwrite_guard(target_link_libraries "")

        vcpkg_target_link_libraries(${ARGV})

        vcpkg_disable_function_overwrite_guard(target_link_libraries "")
    endfunction()
endif()