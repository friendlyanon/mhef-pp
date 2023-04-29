if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/mhef-pp-${PROJECT_VERSION}"
      CACHE PATH ""
  )
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package mhef-pp)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT mhef-pp_Development
)

install(
    TARGETS mhef-pp
    EXPORT mhef-ppTargets
    RUNTIME #
    COMPONENT mhef-pp_Runtime
    LIBRARY #
    COMPONENT mhef-pp_Runtime
    NAMELINK_COMPONENT mhef-pp_Development
    ARCHIVE #
    COMPONENT mhef-pp_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    mhef-pp_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE PATH "CMake package config location relative to the install prefix"
)
mark_as_advanced(mhef-pp_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${mhef-pp_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT mhef-pp_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${mhef-pp_INSTALL_CMAKEDIR}"
    COMPONENT mhef-pp_Development
)

install(
    EXPORT mhef-ppTargets
    NAMESPACE mhef-pp::
    DESTINATION "${mhef-pp_INSTALL_CMAKEDIR}"
    COMPONENT mhef-pp_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
