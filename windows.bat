@echo off
REM Go to the project root (where this .bat is placed)
cd /d %~dp0

REM Path to premake
set PREMAKE=.\Vendor\Premake\Windows\premake5.exe

REM Run premake commands
%PREMAKE% gmake
%PREMAKE% export-compile-commands
%PREMAKE% merge-compile-commands

REM Delete the intermediate compile_commands folder
if exist compile_commands (
    rmdir /s /q compile_commands
    echo Deleted intermediate compile_commands folder
)

echo.
echo  Premake tasks completed!
pause
