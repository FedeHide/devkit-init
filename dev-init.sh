#!/bin/bash

outputDirectory="$1" 

# Checks that a output directory has been provided as an argument
if [ -z "$1" ]; then
    echo "Error: You need to specify an output directory"
    exit 1
fi

mkdir -p $outputDirectory/dist/js $outputDirectory/dist/css $outputDirectory/src/scss/base $outputDirectory/src/scss/components $outputDirectory/src/scss/layout $outputDirectory/src/scss/utils $outputDirectory/src/ts $outputDirectory/public/favicon $outputDirectory/public/images
cp init.js $outputDirectory/init.js
cp template.json $outputDirectory/template.json
echo "🦁 directory tree created 🦁"


# Waiting for directory tree creation
read -p "Press Enter to continue..."
echo "🦁 Updating files 🦁"
cd "$outputDirectory"
tsc --init
node init.js "$outputDirectory"
touch NOTES.md src/ts/main.ts

# Waiting for init.js to finish executing
read -p "Press Enter to continue..."
pnpm install -D sass
pnpm install -D node-sass
pnpm install -D nodemon
pnpm install -D prettier
pnpx eslint --init
pnpm install -D eslint-config-prettier
rm init.js
rm template.json
echo "🦁 Dependencies installed 🦁"

# Initial commit
git init
git add .
git commit -m 'initial commit'

# open Visual Studio Code
code "$outputDirectory"

echo "🦁 Process completed successfully 🦁"