add_library(unofficial::node-api::node-api UNKNOWN IMPORTED)

find_path(node-api_INCLUDE_DIR
  NAMES node.h
  PATHS "${CMAKE_CURRENT_LIST_DIR}/../../include/node"
  NO_DEFAULT_PATH
  REQUIRED)
set_target_properties(unofficial::node-api::node-api PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${node-api_INCLUDE_DIR}"
)

if(WIN32)
  find_library(node-api_LIBRARY_RELEASE NAMES node PATHS "${CMAKE_CURRENT_LIST_DIR}/../../lib" NO_DEFAULT_PATH REQUIRED)
  find_library(node-api_LIBRARY_DEBUG NAMES node PATHS "${CMAKE_CURRENT_LIST_DIR}/../../debug/lib" NO_DEFAULT_PATH REQUIRED)
  set_target_properties(unofficial::node-api::node-api PROPERTIES
    IMPORTED_LOCATION_DEBUG "${node-api_LIBRARY_DEBUG}"
    IMPORTED_LOCATION_RELEASE "${node-api_LIBRARY_RELEASE}"
  )

  target_sources(unofficial::node-api::node-api INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../node-api/win_delay_load_hook.cc>
    $<INSTALL_INTERFACE:lib>)
endif()
