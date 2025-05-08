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
pnpm init # >/dev/null 2>&1
progress_bar

## MAKING folders
folders=(
    "src/ts"
    "src/js"
    "src/css"
    "public/assets"
)
progress_bar
mkdir -p "${folders[@]}" # >/dev/null 2>&1
touch src/ts/main.ts
progress_bar

## ESLINT RULES
eslint_rules=(
    "eslint@latest"
    "eslint-config-love@latest"
    "eslint-plugin-import@latest"
    "eslint-plugin-n@latest"
    "eslint-plugin-promise@latest"
    "eslint-plugin-unused-imports@latest"    
    "eslint-plugin-prettier@latest"
    "eslint-config-prettier@latest"
)
progress_bar
pnpm add "${eslint_rules[@]}" -D # >/dev/null 2>&1
progress_bar
touch .eslintrc.json
progress_bar

## TYPESCRIPT
typescript_dependencies=(
    "typescript@latest"
    "eslint-import-resolver-typescript@latest"
    "@types/node@latest"
    "@typescript-eslint/eslint-plugin@latest"
    "@typescript-eslint/parser@latest"
)
pnpm add "${typescript_dependencies[@]}" -D # >/dev/null 2>&1
progress_bar

## OTHER DEPENDENCIES
other_dependencies=(
    "prettier@latest"
    "rollup"
    "postcss"
    "rollup-plugin-postcss"
    "postcss-import"
)
pnpm add "${other_dependencies[@]}" -D # >/dev/null 2>&1
progress_bar
touch rollup.config.js

cd ..
progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar
