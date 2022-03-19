cmake_minimum_required(VERSION 3.15)

project(SHA256)

add_library(sha256
    src/SHA256.cpp
)
target_include_directories(sha256 PUBLIC "${PROJECT_SOURCE_DIR}/include")

add_executable(sha256-example
    src/main.cpp
)
target_include_directories(sha256-example PUBLIC "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(sha256-example sha256)
