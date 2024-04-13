#include <iostream>
#include <unistd.h>
#include <libgen.h> // for dirname
#include <limits.h> // for PATH_MAX
#include <mach-o/dyld.h>

int setWorkingDirectory()
{
    uint32_t bufSize = PATH_MAX;
    
    // Buffer to store the path of the executable
    char executablePath[bufSize];

    // Get the path of the executable
    if (_NSGetExecutablePath(executablePath, &bufSize) != 0) {
        // Buffer size is too small.
        return 1;
    }

    // Get the directory containing the executable
    char* executableDirectory = dirname(executablePath);

    // Get the parent directory
    char* expectedWorkingDirectory = dirname(executableDirectory);

    // Change the working directory
    if (chdir(expectedWorkingDirectory) != 0) {
        std::cerr << "Error: Unable to change working directory\n";
        return 1;
    }

    // Now the working directory has been changed
    std::cout << "Working directory changed to: " << expectedWorkingDirectory << std::endl;
    
    return 0;
}