#!/bin/bash

cd "$(dirname "$0")"

# Path to premake executable (ensure it's executable: chmod +x premake5)
PREMAKE=./Vendor/Premake/Mac/premake5

"$PREMAKE" gmake2


echo
echo "Premake tasks completed!"
read -p "Press enter to continue..."
