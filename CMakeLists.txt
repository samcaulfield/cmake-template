cmake_minimum_required(VERSION 3.0)

project(libtest VERSION 1.0.0 LANGUAGES CXX)

#
# Build rules
#

option(BUILD_SHARED_LIBS "Build shared libraries" OFF)

# If the build type was not specified, attempt to guess a sensible default.
if (NOT CMAKE_BUILD_TYPE)
  if (EXISTS "${CMAKE_SOURCE_DIR}/.git")
    set(CMAKE_BUILD_TYPE "Debug")
  else ()
    set(CMAKE_BUILD_TYPE "Release")
  endif ()
endif ()

add_library(libtest src/libtest.cpp)

# When building, the include directories should be found in the source tree.
# When installed, the include directories should be found in the install tree.
target_include_directories(libtest PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>)

# CMake automatically prefixes the library target file name with "lib", so the
# file would be called "liblibtest". Disable the extra prefix.
set_target_properties(libtest PROPERTIES PREFIX "")

# Suffix the library file name with the project's version number.
if (${BUILD_SHARED_LIBS})
  set_target_properties(libtest PROPERTIES SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX}.${PROJECT_VERSION})
else (${BUILD_SHARED_LIBS})
  set_target_properties(libtest PROPERTIES SUFFIX ${CMAKE_STATIC_LIBRARY_SUFFIX}.${PROJECT_VERSION})
endif (${BUILD_SHARED_LIBS})

target_compile_features(libtest PUBLIC cxx_std_11)

#
# Installation rules
#

# Rule for installing the library
install(
  TARGETS libtest
  EXPORT libtest-targets
  DESTINATION "lib/libtest-${PROJECT_VERSION}/${CMAKE_BUILD_TYPE}"
)

# Rule for installing the headers
install(
  FILES include/libtest.hpp
  DESTINATION "include/libtest"
)

# Copy the version file to the build directory, setting the project version in
# the file to the project version.
configure_file(cmake/libtest-config-version.cmake ${CMAKE_CURRENT_BINARY_DIR}/libtest-config-version.cmake @ONLY)

#
# Packaging rules
#

# For other CMake projects to be able to use the target, a CMake file that
# describes how to import targets from this project's installation tree into
# that project needs to be installed too.
install(
  EXPORT libtest-targets
  DESTINATION "lib/libtest-${PROJECT_VERSION}"
)

# The package version and configuration files must also be installed.
install(
  FILES ${CMAKE_CURRENT_BINARY_DIR}/libtest-config-version.cmake cmake/libtest-config.cmake
  DESTINATION "lib/libtest-${PROJECT_VERSION}"
)

