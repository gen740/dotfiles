cmake_minimum_required(VERSION 3.28)

project(get_state CXX)

set(CMAKE_CXX_STANDARD 23)

# Setting Build Type
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
endif()

# set release flag
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -ffast-math")
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0")

message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")

set(CMAKE_CXX_FLAGS
  "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror -Wnon-virtual-dtor -Wfloat-equal -Winline -Wno-deprecated-declarations")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color=always")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -stdlib=libc++") # Force to use libc++

add_library(get_state)

file(GLOB LIBRARY_SOURCES ${CMAKE_CURRENT_LIST_DIR}/src/*.cc
     ${CMAKE_CURRENT_LIST_DIR}/src/**/*.cc)
file(GLOB LIBRARY_MODULE_SOURCES ${CMAKE_CURRENT_LIST_DIR}/src/*.ccm
     ${CMAKE_CURRENT_LIST_DIR}/src/**/*.ccm)
target_sources(get_state PUBLIC FILE_SET CXX_MODULES FILES ${LIBRARY_SOURCES}
                                ${LIBRARY_MODULE_SOURCES})

add_executable(zsh_status main.cc)
target_link_libraries(zsh_status get_state)
install(TARGETS zsh_status DESTINATION bin)
