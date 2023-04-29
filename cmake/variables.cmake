# ---- Developer mode ----

# Developer mode enables targets and code paths in the CMake scripts that are
# only relevant for the developer(s) of mhef-pp
# Targets necessary to build the project must be provided unconditionally, so
# consumers can trivially build and package the project
if(PROJECT_IS_TOP_LEVEL)
  option(mhef-pp_DEVELOPER_MODE "Enable developer mode" OFF)
  option(BUILD_SHARED_LIBS "Build shared libs." OFF)
endif()

# ---- Suppress C4251 on Windows ----

# Please see include/mhef-pp/mhef-pp.hpp for more details
set(pragma_suppress_c4251 "
/* This needs to suppress only for MSVC */
#if defined(_MSC_VER) && !defined(__ICL)
#  define MHEF_PP_SUPPRESS_C4251 _Pragma(\"warning(suppress:4251)\")
#else
#  define MHEF_PP_SUPPRESS_C4251
#endif
")
