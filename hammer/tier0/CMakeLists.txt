# tier0
set(CURRENT_TARGET_NAME tier0)

set(SOURCES
    assert_dialog.cpp
    resource.h
    dbg.cpp
    pch_tier0.h
    fasttimer.cpp
)

if(WIN32)
    list(APPEND SOURCES assert_dialog.rc)
endif()

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
