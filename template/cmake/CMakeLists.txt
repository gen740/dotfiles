cmake_minimum_required(VERSION 3.20)

project(test CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS "on")

# Checking Build Type
if("${CMAKE_BUILD_TYPE}" STREQUAL "")
  set(CMAKE_BUILD_TYPE DEBUG)
endif()

message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")

set(CMAKE_CXX_FLAGS "-Werror -Wall -Wextra")

file(GLOB SOURCE ${CMAKE_CURRENT_LIST_DIR}/src/*.cpp)
add_executable(${PROJECT_NAME} ${SOURCE})

set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 20)

target_include_directories(${PROJECT_NAME}
                           PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)
