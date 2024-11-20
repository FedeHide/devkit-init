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
npx create-next-app@latest "$outputDirectory" --no-turbopack --ts --tailwind --eslint --app --src-dir --import-alias "@/*" --use-pnpm >/dev/null 2>&1

progress_bar
cd "$outputDirectory" || exit 1
rm -rf ".git" 2>/dev/null

## MAKING folders
src_folders=(
    "src/components"
    "src/hooks"
    "src/interfaces"
    "src/lib"
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


## ESLINT RULES
## eslint@8.57.1 -> because peer dependency issues with eslint-config-standard
## eslint-plugin-import-helpers@1.3.1 -> because peer dependency issues with eslint 8
## eslint-plugin-n@^16 eslint-plugin-promise@^6 -> because peer dependency issues with eslint-config-standard
progress_bar
pnpm install -D eslint@8.57.1 eslint-config-standard@latest eslint-plugin-react@latest eslint-plugin-import@latest eslint-plugin-n@^16 eslint-plugin-promise@^6 eslint-plugin-import-helpers@1.3.1 eslint-plugin-unused-imports@latest eslint-plugin-react-hooks@latest eslint-plugin-jsx-a11y@latest >/dev/null 2>&1
progress_bar
touch .eslintrc.json

## TS RULES
pnpm install -D typescript@latest @types/react@latest @types/react-dom@latest @types/node@latest eslint-import-resolver-typescript@latest >/dev/null 2>&1
pnpm install -D @typescript-eslint/eslint-plugin@latest @typescript-eslint/parser >/dev/null 2>&1
progress_bar

## PRETTIER + ESLINT plugin
pnpm install -D prettier@latest >/dev/null 2>&1
pnpm install -D eslint-plugin-prettier@latest eslint-config-prettier@latest >/dev/null 2>&1
pnpm install -D prettier-plugin-tailwindcss@latest >/dev/null 2>&1
progress_bar

## TAILWIND ESLINT plugin
pnpm install -D eslint-plugin-tailwindcss@latest >/dev/null 2>&1


# SASS
pnpm install -D sass@latest >/dev/null 2>&1
progress_bar

## ADD SITEMAP PLUGIN
pnpm add next-sitemap@latest -D >/dev/null 2>&1

cd ..
progress_bar
## CLEANING
rm "$outputDirectory"/src/app/page.tsx "$outputDirectory"/src/app/layout.tsx 2>/dev/null
rm "$outputDirectory"/src/app/globals.css "$outputDirectory"/src/app/page.module.css 2>/dev/null
rm "$outputDirectory"/public/next.svg "$outputDirectory"/public/vercel.svg "$outputDirectory"/src/app/favicon.ico 2>/dev/null

progress_bar
## TEMPLATE init
node "$TEMPLATE_JS_DIR" "$outputDirectory"
progress_bar
