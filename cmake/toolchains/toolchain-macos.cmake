# the name of the target operating system and version
set(CMAKE_SYSTEM_NAME Darwin)
set(CMAKE_SYSTEM_VERSION 13.1)

# CPU arch
set(CMAKE_SYSTEM_PROCESSOR arm64)

# which compilers to use for C and C++
set(CMAKE_C_COMPILER oa64-clang)
set(CMAKE_CXX_COMPILER oa64-clang++)

set(CMAKE_INSTALL_NAME_TOOL /osxcross/build/cctools-port/cctools/misc/install_name_tool)

# where is the target environment located
set(CMAKE_OSX_SYSROOT  "/osxcross/target/SDK/MacOSX13.1.sdk")

# adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# search headers and libraries in the target environment
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)