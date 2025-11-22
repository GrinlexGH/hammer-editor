# hammer
set(PROJECTS
    tier0
)

# Output directories
set(HAMMER_ROOT_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/.output/$<CONFIG>)
set(HAMMER_BIN_OUTPUT_DIRECTORY ${HAMMER_ROOT_OUTPUT_DIRECTORY}/bin)
set(HAMMER_LIB_OUTPUT_DIRECTORY ${HAMMER_ROOT_OUTPUT_DIRECTORY}/lib)
set(HAMMER_SHADER_OUTPUT_DIRECTORY ${HAMMER_ROOT_OUTPUT_DIRECTORY}/shaders)

set(CMAKE_PDB_OUTPUT_DIRECTORY ${HAMMER_BIN_OUTPUT_DIRECTORY})
set(CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY ${HAMMER_BIN_OUTPUT_DIRECTORY})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${HAMMER_BIN_OUTPUT_DIRECTORY})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${HAMMER_BIN_OUTPUT_DIRECTORY})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${HAMMER_LIB_OUTPUT_DIRECTORY})

# Portability parameters
set(CMAKE_SKIP_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE)
set(CMAKE_INSTALL_RPATH "$ORIGIN")

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# Warnings
if(IS_GNU_LIKE)
    add_compile_options(
        "-Wall" "-Wextra" "-Wpedantic"
        #"$<$<CONFIG:Release>:-Werror>"
    )
elseif(IS_MSVC_LIKE)
    add_compile_options(
        "/W4"
        #"$<$<CONFIG:Release>:/WX>"
    )
endif()

# All global macros
add_compile_definitions(
    $<$<CONFIG:Debug>:DEBUG> $<$<CONFIG:RelWithDebInfo>:DEBUG>
)

if(WIN32)
    add_compile_definitions(PLATFORM_WINDOWS=1)
endif()

if(UNIX)
    add_compile_definitions(PLATFORM_UNIX=1)
endif()

if(LINUX)
    add_compile_definitions(PLATFORM_LINUX=1)
endif()

if(APPLE)
    add_compile_definitions(PLATFORM_APPLE=1)
endif()

if(ANDROID)
    add_compile_definitions(PLATFORM_ANDROID=1)
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    add_compile_definitions(ARCH_64=1)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    add_compile_definitions(ARCH_32=1)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC" OR CMAKE_CXX_SIMULATE_ID MATCHES "MSVC")
    add_compile_definitions(COMPILER_MSVC=1)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        add_compile_definitions(COMPILER_MSVC64=1)
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
        add_compile_definitions(COMPILER_MSVC32=1)
    endif()
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    add_compile_definitions(COMPILER_GCC=1)
endif()

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|AppleClang")
    add_compile_definitions(COMPILER_CLANG=1)
endif()

include_directories(public)
include_directories(public/tier0)

foreach(PROJECT ${PROJECTS})
    add_subdirectory("${PROJECT}")
    if(WIN32)
        set_target_properties(${PROJECT} PROPERTIES PREFIX "")
    endif()
endforeach()
