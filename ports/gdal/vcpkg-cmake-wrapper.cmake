include(SelectLibraryConfigurations)

find_path(GDAL_INCLUDE_DIR
    NAMES gdal.h
    PATHS "${CMAKE_CURRENT_LIST_DIR}/../../include"
    NO_DEFAULT_PATH
)
find_library(GDAL_LIBRARY_DEBUG
    NAMES gdal_d gdal_i_d gdal
    NAMES_PER_DIR
    PATHS "${CMAKE_CURRENT_LIST_DIR}/../../debug/lib"
    NO_DEFAULT_PATH
)
find_library(GDAL_LIBRARY_RELEASE
    NAMES gdal_i gdal
    NAMES_PER_DIR
    PATHS "${CMAKE_CURRENT_LIST_DIR}/../../lib"
    NO_DEFAULT_PATH
)
select_library_configurations(GDAL)

if(NOT GDAL_INCLUDE_DIR OR NOT GDAL_LIBRARY)
    message(FATAL_ERROR "Installation of vcpkg port gdal is broken.")
endif()

set(GDAL_LIBRARY "${GDAL_LIBRARY}" CACHE STRING "")

set(FindGDAL_SKIP_GDAL_CONFIG TRUE)

_find_package(${ARGS})

set(_gdal_dep_find_args "")
if(";${ARGS};" MATCHES ";REQUIRED;")
    list(APPEND _gdal_dep_find_args "REQUIRED")
endif()
function(_gdal_add_dependency target package)
    find_package(${package} ${ARGN} ${_gdal_dep_find_args})
    if(${package}_FOUND)
        foreach(suffix IN ITEMS "" "-shared" "_shared" "-static" "_static" "-NOTFOUND")
            set(dependency "${target}${suffix}")
            if(TARGET ${dependency})
                break()
            endif()
        endforeach()
        if(NOT TARGET ${dependency})
            string(TOUPPER ${package} _gdal_deps_package)
            if(DEFINED ${_gdal_deps_package}_LIBRARIES)
                set(dependency ${${_gdal_deps_package}_LIBRARIES})
            elseif(DEFINED ${package}_LIBRARIES)
                set(dependency ${${package}_LIBRARIES})
            elseif(DEFINED ${_gdal_deps_package}_LIBRARY)
                set(dependency ${${_gdal_deps_package}_LIBRARY})
            elseif(DEFINED ${package}_LIBRARY)
                set(dependency ${${package}_LIBRARY})
            endif()
        endif()
        if(dependency)
            if(TARGET GDAL::GDAL) # CMake 3.14
                set_property(TARGET GDAL::GDAL APPEND PROPERTY INTERFACE_LINK_LIBRARIES ${dependency})
            endif()
            if(NOT GDAL_LIBRARIES STREQUAL "GDAL::GDAL")
                set(GDAL_LIBRARIES "${GDAL_LIBRARIES};${dependency}" PARENT_SCOPE)
            endif()
        else()
            message(WARNING "Did not find which libraries are exported by ${package}")
            set(GDAL_FOUND false PARENT_SCOPE)
        endif()
    else()
        message(WARNING "Could not find package ${package}")
        set(GDAL_FOUND false PARENT_SCOPE)
    endif()
endfunction()
function(z_vcpkg_gdal_add_libs keyword config)
    set(gdal_deps_target "unofficial::gdal::deps::${keyword}")
    if(NOT TARGET "${gdal_deps_target}")
        add_library("${gdal_deps_target}" INTERFACE IMPORTED)
        if(TARGET GDAL::GDAL) # CMake 3.14
            set_property(TARGET GDAL::GDAL APPEND PROPERTY INTERFACE_LINK_LIBRARIES "$<$<CONFIG:${config}>:${gdal_deps_target}>")
        endif()
        if(NOT GDAL_LIBRARIES STREQUAL "GDAL::GDAL")
            set(GDAL_LIBRARIES "${GDAL_LIBRARIES};${keyword};${gdal_deps_target}" PARENT_SCOPE)
        endif()
    endif()
    # The Ninja build system stumbles over '/libpath:` in INTERFACE_LINK_LIBRARIES.
    set(lib_paths "${ARGN}")
    list(REMOVE_DUPLICATES lib_paths) # For lib paths, late duplicates are redundant.
    foreach(item IN LISTS lib_paths)
        # INTERFACE_LINK_OPTIONS needs CMake 3.13. There is no direct alternative for older versions.
        if(item MATCHES "^/libpath:(.*)|^-L")
            set_property(TARGET "${gdal_deps_target}" APPEND PROPERTY INTERFACE_LINK_OPTIONS "${item}")
            list(REMOVE_ITEM ARGN "${item}")
        endif()
    endforeach()
    foreach(item IN LISTS ARGN)
        get_property(libs TARGET "${gdal_deps_target}" PROPERTY INTERFACE_LINK_LIBRARIES)
        if(item MATCHES "^-l|-pthread")
            list(REMOVE_ITEM libs "${item}") # For libs, early duplicates are normally redundant.
        endif()
        list(APPEND libs "${item}")
        set_property(TARGET "${gdal_deps_target}" PROPERTY INTERFACE_LINK_LIBRARIES "${libs}")
    endforeach()
endfunction()
if(GDAL_FOUND)
    cmake_policy(PUSH)
    cmake_policy(SET CMP0057 NEW)
    set(Z_VCPKG_PORT_FEATURES "@FEATURES@")
    if("cfitsio" IN_LIST Z_VCPKG_PORT_FEATURES)
        _gdal_add_dependency(cfitsio  unofficial-cfitsio CONFIG)
    endif()
    _gdal_add_dependency(CURL::libcurl  CURL CONFIG)
    _gdal_add_dependency(expat::expat  expat CONFIG)
    _gdal_add_dependency(GEOS::geos_c  geos CONFIG)
    if(NOT "@NMAKE_BUILD@")
        _gdal_add_dependency(GIF::GIF  GIF)
    endif()
    if("hdf5" IN_LIST Z_VCPKG_PORT_FEATURES)
        _gdal_add_dependency(hdf5::hdf5  hdf5 CONFIG)
    endif()
    if(NOT "@NMAKE_BUILD@")
        _gdal_add_dependency(json-c::json-c  json-c CONFIG)
    endif()
    _gdal_add_dependency(geotiff_library  GeoTIFF CONFIG)
    _gdal_add_dependency(JPEG::JPEG  JPEG)
    _gdal_add_dependency(liblzma::liblzma  liblzma CONFIG)
    _gdal_add_dependency(png  libpng CONFIG)
    if("postgresql" IN_LIST Z_VCPKG_PORT_FEATURES)
        _gdal_add_dependency(PostgreSQL::PostgreSQL  PostgreSQL)
    endif()
    _gdal_add_dependency(WebP::webp  WebP CONFIG)
    _gdal_add_dependency(LibXml2::LibXml2  LibXml2)
    if("netcdf" IN_LIST Z_VCPKG_PORT_FEATURES)
        _gdal_add_dependency(netCDF::netcdf  netCDF CONFIG)
    endif()
    _gdal_add_dependency(openjp2  OpenJPEG CONFIG)
    _gdal_add_dependency(poppler poppler CONFIG)
    _gdal_add_dependency(PROJ::proj  PROJ4 CONFIG)
    _gdal_add_dependency(unofficial::sqlite3::sqlite3  unofficial-sqlite3 CONFIG)
    _gdal_add_dependency(TIFF::TIFF  TIFF)
    _gdal_add_dependency(ZLIB::ZLIB  ZLIB)
    _gdal_add_dependency(zstd::libzstd  zstd CONFIG)
    z_vcpkg_gdal_add_libs(optimized Release @GDAL_EXTRA_LIBS_RELEASE@)
    z_vcpkg_gdal_add_libs(debug Debug @GDAL_EXTRA_LIBS_DEBUG@)
    list(FIND ARGS "REQUIRED" required)
    if(NOT GDAL_FOUND AND NOT required EQUAL "-1")
        message(FATAL_ERROR "Failed to find dependencies of GDAL")
    endif()
    unset(Z_VCPKG_PORT_FEATURES)
    cmake_policy(POP)
endif()
