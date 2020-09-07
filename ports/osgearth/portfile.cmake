vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY ONLY_DYNAMIC_CRT)

file(GLOB OSG_PLUGINS_SUBDIR ${CURRENT_INSTALLED_DIR}/tools/osg/osgPlugins-*)
list(LENGTH OSG_PLUGINS_SUBDIR OSG_PLUGINS_SUBDIR_LENGTH)
if(NOT OSG_PLUGINS_SUBDIR_LENGTH EQUAL 1)
    message(FATAL_ERROR "Could not determine osg version")
endif()
string(REPLACE "${CURRENT_INSTALLED_DIR}/tools/osg/" "" OSG_PLUGINS_SUBDIR "${OSG_PLUGINS_SUBDIR}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gwaldron/osgearth
    REF ef631e0933390ca33b727392392efea2400e60a6     #version 3.0
    SHA512 df17c12ef0f9833c3a601aac7ffe8a6600a06d85865300a282aba6aacec6edd4d14ace86ae11b68c45dbbef3851436eff30b3fd7eee8696e8752cd22886c092b
    HEAD_REF master
    PATCHES 
  	  RocksDB.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

#Release
set(OSGEARTH_TOOL_PATH ${CURRENT_PACKAGES_DIR}/tools/${PORT})
set(OSGEARTH_TOOL_PLUGIN_PATH ${OSGEARTH_TOOL_PATH}/${OSG_PLUGINS_SUBDIR})

file(MAKE_DIRECTORY ${OSGEARTH_TOOL_PATH})
file(MAKE_DIRECTORY ${OSGEARTH_TOOL_PLUGIN_PATH})

file(GLOB OSGEARTH_TOOLS ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(GLOB OSGDB_PLUGINS ${CURRENT_PACKAGES_DIR}/bin/osgdb*.dll)

file(COPY ${OSGEARTH_TOOLS} DESTINATION ${OSGEARTH_TOOL_PATH})
file(COPY ${OSGDB_PLUGINS} DESTINATION ${OSGEARTH_TOOL_PLUGIN_PATH})

file(REMOVE_RECURSE ${OSGEARTH_TOOLS})
file(REMOVE_RECURSE ${OSGDB_PLUGINS})

#Debug
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

set(OSGEARTH_DEBUG_TOOL_PATH ${CURRENT_PACKAGES_DIR}/debug/tools/${PORT})
set(OSGEARTH_DEBUG_TOOL_PLUGIN_PATH ${OSGEARTH_DEBUG_TOOL_PATH}/${OSG_PLUGINS_SUBDIR})

file(MAKE_DIRECTORY ${OSGEARTH_DEBUG_TOOL_PATH})
file(MAKE_DIRECTORY ${OSGEARTH_DEBUG_TOOL_PLUGIN_PATH})

file(GLOB OSGEARTH_DEBUG_TOOLS ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
file(GLOB OSGDB_DEBUG_PLUGINS ${CURRENT_PACKAGES_DIR}/debug/bin/osgdb*.dll)

file(COPY ${OSGEARTH_DEBUG_TOOLS} DESTINATION ${OSGEARTH_DEBUG_TOOL_PATH})
file(COPY ${OSGDB_DEBUG_PLUGINS} DESTINATION ${OSGEARTH_DEBUG_TOOL_PLUGIN_PATH})

file(REMOVE_RECURSE ${OSGEARTH_DEBUG_TOOLS})
file(REMOVE_RECURSE ${OSGDB_DEBUG_PLUGINS})


# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
