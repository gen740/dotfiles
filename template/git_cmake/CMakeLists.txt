cmake_minimum_required(VERSION 3.20)

project(test CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS "on")

message("
============================================================
Building on ${CMAKE_BUILD_TYPE} Mode
============================================================")

if(NOT CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  message(FATAL_ERROR "
    You cannot use compiler except for clang, set compiler to
    clang setting CMAKE_CXX_COMPILER environmetal variable.
    ")
endif()

# Set cmpile flags
add_compile_options(-std=c++20)
add_compile_options(-Wall)
add_compile_options(-O3)

file(GLOB SOURCE src/*.cpp)

add_executable(main ${SOURCE})
