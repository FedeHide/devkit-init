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
cd "$outputDirectory" || exit 1
pnpm init > /dev/null 2>&1
pnpm install -D rollup >/dev/null 2>&1
touch rollup.config.js
progress_bar

## MAKING folders
dist_folders=(
    "dist/js"
    "dist/css"
)

src_folders=(
    "src/ts"
    "src/js"
    "src/css"
)
progress_bar

root_folders=(
    "public/assets"
)

progress_bar
for folder in "${src_folders[@]}" "${root_folders[@]}" "${dist_folders[@]}"; do
    mkdir -p "$folder"
done
touch src/ts/main.ts
progress_bar

## PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
progress_bar
pnpm install -D typescript@latest eslint@latest @typescript-eslint/eslint-plugin@^6.4.0 eslint-config-love@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-prettier@latest >/dev/null 2>&1
progress_bar
touch .eslintrc.json

cd ..
progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar
