# tier0
set(CURRENT_TARGET_NAME tier0)

set(SOURCES
    dbg.cpp
)

add_library(${CURRENT_TARGET_NAME} SHARED ${SOURCES})

target_compile_definitions(
    ${CURRENT_TARGET_NAME}
    PRIVATE
    TIER0_DLL_EXPORT=1
    WAF_CFLAGS="dummy"
    WAF_LDFLAGS="dummy"
)

target_precompile_headers(${CURRENT_TARGET_NAME} PRIVATE pch_tier0.h)

foreach(source IN LISTS SOURCES)
    cmake_path(GET source PARENT_PATH source_directory)
    source_group("Source Files/${source_directory}" FILES "${source}")
endforeach()

deps_target_link_libraries(${CURRENT_TARGET_NAME}
    PRIVATE
    nowide::nowide
)
