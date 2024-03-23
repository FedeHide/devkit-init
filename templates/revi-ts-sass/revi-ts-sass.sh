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
pnpm create vite "$outputDirectory" --template react-swc-ts >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
pnpm install >/dev/null 2>&1

## MAKING folders
src_folders=(
    "src/components"
    "src/hooks"
)

sass_folders=(
    "src/scss/base"
    "src/scss/layout"
    "src/scss/utils"
)

root_folders=(
    "favicon"
    "css"
    "assets"
)

progress_bar
for folder in "${src_folders[@]}" "${sass_folders[@]}" "${root_folders[@]}"; do
    mkdir -p "$folder"
done
progress_bar

## PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-prettier@latest >/dev/null 2>&1
touch .eslintrc.json
progress_bar

# SASS
pnpm install -D sass >/dev/null 2>&1
progress_bar
pnpm install -D nodemon >/dev/null 2>&1

cd ..
## CLEANING
progress_bar
rm "$outputDirectory"/src/main.tsx "$outputDirectory"/src/App.tsx "$outputDirectory"/src/App.css "$outputDirectory"/src/index.css
rm "$outputDirectory"/public/vite.svg
rm -rf "$outputDirectory"/src/assets
progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar