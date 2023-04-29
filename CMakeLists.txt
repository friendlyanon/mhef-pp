cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    mhef-pp
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(mhef-pp source/mhef-pp.cpp)
add_library(mhef-pp::mhef-pp ALIAS mhef-pp)

include(GenerateExportHeader)
generate_export_header(
    mhef-pp
    EXPORT_FILE_NAME export/mhef-pp/mhef-pp_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(mhef-pp PUBLIC MHEF_PP_STATIC_DEFINE)
endif()

set_target_properties(
    mhef-pp PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
)

target_include_directories(
    mhef-pp
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    mhef-pp SYSTEM
    PUBLIC
    "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(mhef-pp PUBLIC cxx_std_17)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT mhef-pp_DEVELOPER_MODE)
  return()
endif()

include(cmake/dev-mode.cmake)
