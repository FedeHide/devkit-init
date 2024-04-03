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
pnpm create next-app@latest "$outputDirectory" --js --tailwind --no-eslint --app --src-dir --import-alias "@/*" --use-pnpm >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
rm -rf ".git"

## MAKING folders
src_folders=(
    "src/components"
    "src/hooks"
)

sass_folders=(
    "src/scss/base"
    "src/scss/layout"
    "src/scss/components"
)

root_folders=(
    "public/assets"
)

for folder in "${src_folders[@]}" "${sass_folders[@]}" "${root_folders[@]}"; do
    mkdir -p "$folder"
done
progress_bar

## PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
progress_bar
pnpm install -D eslint@latest eslint-config-standard@latest eslint-plugin-react@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-next@latest >/dev/null 2>&1
touch .eslintrc.json
pnpm install -D @types/react @types/react-dom >/dev/null 2>&1

# SASS
pnpm install -D sass >/dev/null 2>&1
progress_bar

cd ..
progress_bar
## CLEANING
rm "$outputDirectory"/src/app/page.js "$outputDirectory"/src/app/layout.js
rm "$outputDirectory"/src/app/globals.css "$outputDirectory"/src/app/page.module.css
rm "$outputDirectory"/public/next.svg "$outputDirectory"/public/vercel.svg "$outputDirectory"/src/app/favicon.ico

progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar