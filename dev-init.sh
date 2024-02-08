#!/bin/bash

outputDirectory="$1" 

# Checks that a output directory has been provided as an argument
if [ -z "$1" ]; then
    echo "Error: You need to specify an output directory"
    exit 1
fi

echo "🦁 creating directories 🦁"
mkdir -p $outputDirectory/dist/js $outputDirectory/dist/css $outputDirectory/src/scss/base $outputDirectory/src/scss/components $outputDirectory/src/scss/layout $outputDirectory/src/scss/utils $outputDirectory/src/ts $outputDirectory/public/favicon

node init.js "$outputDirectory"

# Waiting for init.js to finish executing
read -p "Press Enter to continue..."

echo "🦁 installing dependencies 🦁"
cd "$outputDirectory"
pnpm install -D sass
pnpm install -D node-sass
pnpm install -D nodemon
pnpm install -D prettier
tsc --init
pnpx eslint --init
pnpm install -D eslint-config-prettier
touch CONTRIBUTING.md src/ts/main.ts
node update-tsconfig.mjs
rm update-tsconfig.mjs
git init
git add .
git commit -m 'initial commit'

# open Visual Studio Code
code "$outputDirectory"

echo "🦁 Process completed successfully 🦁"