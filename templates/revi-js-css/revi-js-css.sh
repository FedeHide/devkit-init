#!/bin/bash

# PROGRESS BAR VARIABLES
GREEN='\e[0;32m'
RESET_BLOCK='\e[0m'
duration=10
step=1
progress=0
line=""

## PROGRESS BAR FUNCTION
progress_bar() {
    
    # terminal width
    local terminal_width=$(($(tput cols) / 2))

    # initiar bar width
    local full_bar
    full_bar=$(printf '=%.0s' $(seq 1 $((terminal_width * 8 / 10))))

    # calculate bar length
    local progress_length=$(( (progress * terminal_width * 8 / 10) / duration ))

    # print progress bar
    line=$(printf "%-${progress_length}s" " ")
    line=${line// /█}
    echo -ne "\r[${GREEN}${line}${RESET_BLOCK}${full_bar:${progress_length}}] $(( (progress * 100) / duration ))%"
    ((progress += step))
}

progress_bar
# shellcheck disable=SC2154
mkdir "$outputDirectory" || exit 1
pnpm create vite "$outputDirectory" --template react-swc >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1

## MAKING folders
src_folders=(
    "src/components"
    "src/hooks"
)
progress_bar
for folder in "${src_folders[@]}"; do
    mkdir -p "$folder"
done
progress_bar

## PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-standard@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-prettier@latest >/dev/null 2>&1
progress_bar
touch .eslintrc.json

cd ..
# # CLEANING
progress_bar
rm "$outputDirectory"/src/main.jsx "$outputDirectory"/src/App.jsx "$outputDirectory"/src/App.css "$outputDirectory"/src/index.css
rm "$outputDirectory"/public/vite.svg
rm -rf "$outputDirectory"/src/assets
progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar