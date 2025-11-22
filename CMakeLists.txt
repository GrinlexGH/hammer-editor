cmake_minimum_required(VERSION 3.28)
project(HammerEditor VERSION 0.0.0 LANGUAGES CXX C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/Modules")

# Options
option(HAMMER_TRY_TO_USE_LIBCXX "Try to use libc++ in hammer and its dependencies" ON)

# Global settings
include(Hammer/ToolchainSetup)
include(Hammer/CompileOptions)
include(Hammer/ThirdParty)

# Hammer directories
set(HAMMER_ROOT_DIR ${PROJECT_SOURCE_DIR})

# Hammer
include_directories("${PROJECT_SOURCE_DIR}")
add_subdirectory(hammer)
