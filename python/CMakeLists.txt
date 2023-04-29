cmake_minimum_required(VERSION 3.19)

project(mhef-ppBindings LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(mhef-pp REQUIRED)
endif()

find_package(Python 3 REQUIRED Interpreter Development.Module)

find_package(nanobind REQUIRED)
nanobind_build_library(nanobind-static)
get_property(
    nanobind_includes TARGET nanobind-static
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
)
set_target_properties(
    nanobind-static PROPERTIES
    FOLDER nanobind-static
    INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${nanobind_includes}"
)

# ---- Declare bindings module ----

add_library(mhef-pp-bindings MODULE source/main.cpp)
nanobind_extension(mhef-pp-bindings)
nanobind_link_options(mhef-pp-bindings)
set_target_properties(
    mhef-pp-bindings PROPERTIES
    FOLDER BindingsTargets
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    OUTPUT_NAME mhef
)
target_link_libraries(
    mhef-pp-bindings
    PRIVATE mhef-pp::mhef-pp nanobind-static
)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  install(
      TARGETS mhef-pp-bindings
      LIBRARY #
      DESTINATION .
      COMPONENT mhef-pp-bindings
  )
endif()

# ---- Testing ----

include(CTest)
if(BUILD_TESTING)
  add_test(
      NAME python
      COMMAND "${CMAKE_COMMAND}"
      -D "path=$\<TARGET_FILE_DIR:mhef-pp-bindings>"
      -D "command=${Python_EXECUTABLE};${PROJECT_SOURCE_DIR}/test/test.py"
      -P "${PROJECT_SOURCE_DIR}/../cmake/pythonpath.cmake"
  )
endif()
