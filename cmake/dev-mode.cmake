include(cmake/folders.cmake)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(test)
endif()

option(BUILD_PYTHON_BINDINGS "Build bindigns using nanobind" OFF)
if(BUILD_PYTHON_BINDINGS)
  add_subdirectory(python)
endif()

option(ENABLE_COVERAGE "Enable coverage support separate from CTest's" OFF)
if(ENABLE_COVERAGE)
  include(cmake/coverage.cmake)
endif()

include(cmake/lint-targets.cmake)
include(cmake/spell-targets.cmake)

add_folders(Project)
