set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Set the cross-compilation prefix
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)

# Specify the cross-compilation options and flags
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32;/SFML/extlibs/libs-mingw/x64;/SFML/extlibs/headers)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Specify the cross-compilation target
set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)
set(CMAKE_SYSTEM_PREFIX_PATH SFML/cmake;/usr/x86_64-w64-mingw32)
set(CMAKE_INCLUDE_PATH /usr/lib/gcc/x86_64-w64-mingw32;/usr/lib/gcc/x86_64-w64-mingw32/10-win32;/usr/lib/gcc/x86_64-w64-mingw32/10-win32/include/c++;/SFML/extlibs/headers)
set(CMAKE_PREFIX_PATH /SFML/extlibs/libs-mingw/x64/libs)

# Additional settings specific to SFML
# set(SFML_STATIC_LIBRARIES TRUE)