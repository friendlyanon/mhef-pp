cmake_minimum_required(VERSION 3.14)

project(mhef-ppTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(mhef-pp REQUIRED)
  enable_testing()
endif()

find_package(Catch2 REQUIRED)
include(Catch)

# ---- Tests ----

add_executable(mhef-pp_test source/mhef-pp_test.cpp)
target_link_libraries(
    mhef-pp_test PRIVATE
    mhef-pp::mhef-pp
    Catch2::Catch2WithMain
)
target_compile_features(mhef-pp_test PRIVATE cxx_std_17)

catch_discover_tests(mhef-pp_test)

# ---- End-of-file commands ----

add_folders(Test)
