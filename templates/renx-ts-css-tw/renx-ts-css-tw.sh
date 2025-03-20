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
next_options=(
    "--no-turbopack"
    "--ts"
    "--tailwind"
    "--eslint"
    "--app"
    "--src-dir"
    "--import-alias"
    "@/*"
    "--use-pnpm"
)
npx create-next-app@15.1.4 "$outputDirectory" "${next_options[@]}" >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
rm -rf ".git" 2>/dev/null

## MAKING folders
folders=(
    "src/components"
    "src/hooks"
    "src/interfaces"
    "src/lib"
    "public/assets"
)
progress_bar
mkdir -p "${folders[@]}" 2>/dev/null
progress_bar

## ESLINT RULES
eslint_rules=(
    "eslint@9.18.0"
    "eslint-plugin-react@7.37.4"
    "eslint-plugin-import@2.31.0"
    "eslint-plugin-n@17.15.1"
    "eslint-plugin-promise@7.2.1"
    "eslint-plugin-unused-imports@4.1.4"
    "eslint-plugin-react-hooks@5.1.0"
    "eslint-plugin-jsx-a11y@6.10.2"
    "eslint-plugin-prettier@5.2.2"
    "eslint-config-prettier@10.0.1"
)
progress_bar
pnpm add "${eslint_rules[@]}" -D >/dev/null 2>&1
progress_bar
touch .eslintrc.json

## TYPESCRIPT
typescript_dependencies=(
    "typescript@5.7.3"
    "@types/react@latest"
    "@types/react-dom@latest"
    "@types/node@latest"
    "eslint-import-resolver-typescript@3.7.0"
    "@typescript-eslint/eslint-plugin@latest"
    "@typescript-eslint/parser@latest"
)
pnpm add "${typescript_dependencies[@]}" -D >/dev/null 2>&1
progress_bar

## OTHER DEPENDENCIES
other_dependencies=(
    "prettier@latest"
    "prettier-plugin-tailwindcss@latest"
    "eslint-plugin-tailwindcss@3.17.5"
    "next-sitemap@latest"
)
pnpm add "${other_dependencies[@]}" -D >/dev/null 2>&1
progress_bar


cd ..
progress_bar
## CLEANING
files_to_remove=(
    "/src/app/page.js"
    "/src/app/layout.js"
    "/src/app/globals.css"
    "/public/next.svg"
    "/public/vercel.svg"
    "/src/app/favicon.ico"
    "/public/file.svg"
    "/public/globe.svg"
    "/public/window.svg"
    "/eslint.config.mjs"
    "/next.config.ts"
)
rm -rf "${files_to_remove[@]/#/$outputDirectory}" 2>/dev/null

progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar