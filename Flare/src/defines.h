#pragma once 

#ifdef FLARE_BUILD_DLL
    #define FLARE_API __declspec(dllexport)
#else
    #define FLARE_API __declspec(dllimport)
#endif