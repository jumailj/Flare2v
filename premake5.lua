---@diagnostic disable: undefined-global ( zed to avoid diagnostics on this file)


workspace "FlareWorkspace"
    --filename "Flare" ( to change the workspace name)
    architecture "x64"
    configurations { "Debug", "Release", "Ship" }
    local outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
    startproject "Sandbox"

project "Flare"
    location "Flare"
    kind "SharedLib"
    language "C++"
    cppdialect "C++23"
    staticruntime "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files { "%{prj.name}/src/**.h",
            "%{prj.name}/src/**.cpp" }

    defines "FLARE_EXPORTS" -- to export the symbols when building the DLL

    filter { "configurations:Debug" }
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"

    filter { "configurations:Release" }
        defines { "NDEBUG", "RELEASE" }
        runtime "Release"
        optimize "On"
        symbols "On"

    filter { "configurations:Ship"}
        defines { "NDEBUG", "SHIP" }
        runtime "Release"
        optimize "Full"
        symbols "Off"


project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"
    cppdialect "C++23"
    staticruntime "off"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files { "%{prj.name}/src/**.h",
            "%{prj.name}/src/**.cpp" }

    includedirs { "Flare/src" }
    links { "Flare" }

    filter { "configurations:Debug" }
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"

    filter { "configurations:Release" }
        defines { "NDEBUG", "RELEASE" }
        runtime "Release"
        optimize "On"
        symbols "On"

    filter { "configurations:Ship"}
        defines { "NDEBUG", "SHIP" }
        runtime "Release"
        optimize "Full"
        symbols "Off"


    filter {"system:windows"}
        postbuildcommands {
            ("{COPY} ../bin/" .. outputdir .. "/Flare/Flare.dll %{cfg.targetdir}")
        }


