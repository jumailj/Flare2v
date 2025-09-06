#pragma once 

#if defined(_WIN32) || defined(_WIN64)
    #ifdef FLARE_EXPORTS
        // Exporting symbols (building the DLL)
        #define FLARE_API __declspec(dllexport)
    #else
        // Importing symbols (using the DLL)
        #define FLARE_API __declspec(dllimport)
    #endif
#else
    // On non-Windows platforms, just make everything visible
    #define FLARE_API __attribute__((visibility("default")))
#endif