#include <iostream>
#include <windows.h>

int setWorkingDirectory()
{
    // Buffer to store the path of the executable
    char executablePath[MAX_PATH];

    // Get the path of the executable
    DWORD pathLength = GetModuleFileName(NULL, executablePath, MAX_PATH);
    if (pathLength == 0) {
        std::cerr << "Error: Unable to get executable path\n";
        return 1;
    }

    // Get the directory containing the executable
    char* lastBackslash = strrchr(executablePath, '\\');
    if (lastBackslash != NULL) {
        *lastBackslash = '\0'; // Null-terminate the string at the last backslash
    }

    // Change the working directory
    if (!SetCurrentDirectory(executablePath)) {
        std::cerr << "Error: Unable to change working directory\n";
        return 1;
    }

    // Now the working directory has been changed
    std::cout << "Working directory changed to: " << executablePath << std::endl;
    
    return 0;
}