#!/bin/bash

# Go to the directory where this script is located (project root)
cd "$(dirname "$0")"

# Path to premake executable (make sure it's executable: chmod +x)
PREMAKE=./Vendor/Premake/Linux/premake5


# Run premake commands
"$PREMAKE" gmake


echo
echo "Premake tasks completed!"
read -p "Press enter to continue..."
