#[===[.md:
# vcpkg_copy_tool_dependencies

Copy all DLL dependencies of built tools into the tool folder.

## Usage
```cmake
vcpkg_copy_tool_dependencies(
    TOOL_DIR <${CURRENT_PACKAGES_DIR}/tools/${PORT}>
    [DYNAMIC_DEPENS <dep1>...]
)
```
## TOOL_DIR
The path to the directory containing the tools.

### DYNAMIC_DEPENS
A list of tool’s dynamic dependency library names.

## Notes
This command should always be called by portfiles after they have finished rearranging the binary output, if they have any tools.

## Examples

* [glib](https://github.com/Microsoft/vcpkg/blob/master/ports/glib/portfile.cmake)
* [fltk](https://github.com/Microsoft/vcpkg/blob/master/ports/fltk/portfile.cmake)
#]===]

function(vcpkg_copy_tool_dependencies TOOL_DIR)
    cmake_parse_arguments(PARSE_ARGV 0 _vctd "" "TOOL_DIR" "DYNAMIC_DEPENS")
    if (VCPKG_TARGET_IS_WINDOWS)
        find_program(PWSH_EXE pwsh)
        if (NOT PWSH_EXE)
            if(UNIX AND NOT CYGWIN)
                message(FATAL_ERROR "Could not find PowerShell Core; install PowerShell Core as described here: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux")
            endif()
            message(FATAL_ERROR "Could not find PowerShell Core; please open an issue to report this.")
        endif()
        macro(search_for_dependencies PATH_TO_SEARCH)
            file(GLOB TOOLS "${_vctd_TOOL_DIR}/*.exe" "${_vctd_TOOL_DIR}/*.dll" "${_vctd_TOOL_DIR}/*.pyd")
            foreach(TOOL IN LISTS TOOLS)
                vcpkg_execute_required_process(
                    COMMAND "${PWSH_EXE}" -noprofile -executionpolicy Bypass -nologo
                        -file "${SCRIPTS}/buildsystems/msbuild/applocal.ps1"
                        -targetBinary "${TOOL}"
                        -installedDir "${PATH_TO_SEARCH}"
                    WORKING_DIRECTORY "${VCPKG_ROOT_DIR}"
                    LOGNAME copy-tool-dependencies
                )
            endforeach()
        endmacro()
        search_for_dependencies("${CURRENT_PACKAGES_DIR}/bin")
        search_for_dependencies("${CURRENT_INSTALLED_DIR}/bin")
        
        if (_vctd_DYNAMIC_DEPENS)
            foreach (SEARCH_ITEM ${_vctd_DYNAMIC_DEPENS})
                if (EXISTS "${CURRENT_PACKAGES_DIR}/bin/${SEARCH_ITEM}")
                    debug_message("Copying file ${CURRENT_PACKAGES_DIR}/bin/${SEARCH_ITEM} to ${_vctd_TOOL_DIR}")
                    file(COPY "${CURRENT_PACKAGES_DIR}/bin/${SEARCH_ITEM}" DESTINATION "${_vctd_TOOL_DIR}")
                else()
                    message(WARNING "Dynamic dependency ${SEARCH_ITEM} not found in ${CURRENT_PACKAGES_DIR}/bin.")
                endif()
            endforeach()
        endif()
    endif()
endfunction()
