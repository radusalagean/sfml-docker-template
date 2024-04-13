#include <iostream>
#include <unistd.h>
#include <libgen.h> // for dirname
#include <limits.h> // for PATH_MAX

int setWorkingDirectory()
{
    // Buffer to store the path of the executable
    char executablePath[PATH_MAX];

    // Get the path of the executable
    if (readlink("/proc/self/exe", executablePath, sizeof(executablePath)) == -1) {
        std::cerr << "Error: Unable to get executable path\n";
        return 1;
    }

    // Get the directory containing the executable
    char* directoryPath = dirname(executablePath);

    // Change the working directory
    if (chdir(directoryPath) != 0) {
        std::cerr << "Error: Unable to change working directory\n";
        return 1;
    }

    // Now the working directory has been changed
    std::cout << "Working directory changed to: " << directoryPath << std::endl;
    
    return 0;
}