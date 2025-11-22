# Third party libraries
include(Deps)

if(ANDROID)
    deps_append_cmake_define(ANDROID_ABI)
    deps_append_cmake_define(CMAKE_ANDROID_ARCH_ABI)
endif()

# Compilation
deps_add_cmake_project("nowide" BUILD_DEBUG)

deps_build_all()

# Find these libraries
include_directories(SYSTEM "${DEPS_HEADER_ONLY_INCLUDE_DIR}")

find_package(nowide REQUIRED)
