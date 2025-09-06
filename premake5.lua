---@diagnostic disable: undefined-global ( zed to avoid diagnostics on this file)
require("Vendor/premake-Plugin/export-compile-commands")
require("Vendor/premake-Plugin/merge-compile-commands")


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

    defines "FLARE_BUILD_DLL" -- to export the symbols when building the DLL

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


    filter {}
        postbuildcommands {
            ("{COPY} ../bin/" .. outputdir .. "/Flare/Flare.dll %{cfg.targetdir}")
        }

    newaction {
        trigger     = "merge-compile-commands",
        description = "Merge all compile_commands/*.json into compile_commands.json",
        execute     = function ()
            -- Windows PowerShell merge without leading space/newline
            os.execute('powershell -ExecutionPolicy Bypass -Command "' ..
                '$files = Get-ChildItem compile_commands -Filter *.json; ' ..
                '$all = @(); ' ..
                'foreach ($f in $files) { $all += Get-Content $f.FullName | ConvertFrom-Json }; ' ..
                '($all | ConvertTo-Json -Depth 10) | Set-Content -Encoding utf8 compile_commands.json"')
        end
    }

