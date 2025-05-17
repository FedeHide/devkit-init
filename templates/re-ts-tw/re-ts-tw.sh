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
npx --yes create-next-app@latest "$outputDirectory" "${next_options[@]}" >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
rm -rf ".git" >/dev/null 2>&1

## MAKING folders
folders=(
    "src/components"
    "src/components/ui"
    "src/components/layout"
    "src/components/utils"
    "src/hooks"
    "src/interfaces"
    "src/lib"
    "src/styles"
    "src/styles/base"
    "public/assets"
)
progress_bar
mkdir -p "${folders[@]}" >/dev/null 2>&1
progress_bar

## ESLINT RULES
eslint_rules=(
    "eslint@latest"
    "eslint-plugin-react@latest"
    "eslint-plugin-import@latest"
    "eslint-plugin-n@latest"
    "eslint-plugin-promise@latest"
    "eslint-plugin-unused-imports@latest"
    "eslint-plugin-react-hooks@latest"
    "eslint-plugin-jsx-a11y@latest"
    "eslint-plugin-prettier@latest"
    "eslint-config-prettier@latest"
)
progress_bar
pnpm add "${eslint_rules[@]}" -D >/dev/null 2>&1
progress_bar
touch .eslintrc.json

## TYPESCRIPT
typescript_dependencies=(
    "typescript@latest"
    "@types/react@latest"
    "@types/react-dom@latest"
    "@types/node@latest"
    "eslint-import-resolver-typescript@latest"
    "@typescript-eslint/eslint-plugin@latest"
    "@typescript-eslint/parser@latest"
)
pnpm add "${typescript_dependencies[@]}" -D >/dev/null 2>&1
progress_bar

## OTHER DEPENDENCIES
other_dependencies=(
    "prettier@latest"
    "prettier-plugin-tailwindcss@latest"
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
rm -rf "${files_to_remove[@]/#/$outputDirectory}" >/dev/null 2>&1

progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar