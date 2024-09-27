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
pnpm create next-app@latest "$outputDirectory" --ts --tailwind --no-eslint --app --src-dir --import-alias "@/*" --use-pnpm >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
rm -rf ".git" 2>/dev/null

## MAKING folders
src_folders=(
    "src/components"
    "src/hooks"
    "src/interfaces"
)

progress_bar
root_folders=(
    "public/assets"
)

for folder in "${src_folders[@]}" "${root_folders[@]}"; do
    mkdir -p "$folder"
done
progress_bar

## PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
progress_bar
pnpm install -D typescript@latest eslint@^8.57.0 @typescript-eslint/eslint-plugin@7.8.0 eslint-config-love@latest eslint-plugin-react@latest eslint-plugin-import@latest eslint-plugin-n@16.0.0 eslint-plugin-promise@^6.0.0 >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-prettier@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-config-next@latest >/dev/null 2>&1
touch .eslintrc.json

## ADD SITEMAP PLUGIN
pnpm add next-sitemap -D >/dev/null 2>&1

cd ..
progress_bar
## CLEANING
rm "$outputDirectory"/src/app/page.tsx "$outputDirectory"/src/app/layout.tsx "$outputDirectory"/src/app/globals.css 2>/dev/null
rm "$outputDirectory"/public/next.svg "$outputDirectory"/public/vercel.svg "$outputDirectory"/src/app/favicon.ico 2>/dev/null

progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar