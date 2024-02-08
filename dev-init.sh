#!/bin/bash

outputDirectory="$1" 

# Checks that a output directory has been provided as an argument
if [ -z "$1" ]; then
    echo "Error: You need to specify an output directory"
    exit 1
fi

node init.js "$outputDirectory"

# Waiting for init.js to finish executing
read -p "Press Enter to continue..."

(cd "$outputDirectory" && pnpm run template-init)

# open Visual Studio Code
code "$outputDirectory"

echo "Process completed successfully 🦁"