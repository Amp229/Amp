function(set_library_target NAMESPACE LIB_NAME DEBUG_LIB_FILE_NAME RELEASE_LIB_FILE_NAME INCLUDE_DIR)
    add_library(${NAMESPACE}::${LIB_NAME} STATIC IMPORTED)
    set_target_properties(${NAMESPACE}::${LIB_NAME} PROPERTIES
                          IMPORTED_CONFIGURATIONS "RELEASE;DEBUG"
                          IMPORTED_LOCATION_RELEASE "${RELEASE_LIB_FILE_NAME}"
                          IMPORTED_LOCATION_DEBUG "${DEBUG_LIB_FILE_NAME}"
                          INTERFACE_INCLUDE_DIRECTORIES "${INCLUDE_DIR}"
                          )
    set(${NAMESPACE}_${LIB_NAME}_FOUND 1)
endfunction()

get_filename_component(ROOT "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(ROOT "${ROOT}" PATH)
get_filename_component(ROOT "${ROOT}" PATH)

if (CMAKE_HOST_WIN32)
set_library_target("RYU" "ryu" "${ROOT}/debug/lib/ryu.lib" "${ROOT}/lib/ryu.lib" "${ROOT}/include/")
set_library_target("RYU" "generic_128" "${ROOT}/debug/lib/generic_128.lib" "${ROOT}/lib/generic_128.lib" "${ROOT}/include/")
set_library_target("RYU" "ryu_printf" "${ROOT}/debug/lib/ryu_printf.lib" "${ROOT}/lib/ryu_printf.lib" "${ROOT}/include/")
else()
set_library_target("RYU" "ryu" "${ROOT}/debug/lib/libryu.a" "${ROOT}/lib/libryu.a" "${ROOT}/include/")
set_library_target("RYU" "generic_128" "${ROOT}/debug/lib/libgeneric_128.a" "${ROOT}/lib/libgeneric_128.a" "${ROOT}/include/")
set_library_target("RYU" "ryu_printf" "${ROOT}/debug/lib/libryu_printf.a" "${ROOT}/lib/libryu_printf.a" "${ROOT}/include/")
endif()