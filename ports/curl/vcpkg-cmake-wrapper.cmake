if (${ARGS} MATCHES "CONFIG|NO_MODULE")
    _find_package(${ARGS})
else()
    _find_package(${ARGS} CONFIG)
endif()

if(TARGET CURL::libcurl)
	get_target_property(_curl_include_dirs CURL::libcurl INTERFACE_INCLUDE_DIRECTORIES)
	set(CURL_INCLUDE_DIRS "${_curl_include_dirs}" PARENT_SCOPE)
	set(CURL_LIBRARIES CURL::libcurl PARENT_SCOPE)
	set(CURL_VERSION_STRING "${CURL_VERSION}" PARENT_SCOPE)
endif()
