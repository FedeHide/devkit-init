#!/bin/bash

## VARIABLES
# COLOR VARIABLES
GREY="\033[1;30m"
RED="\033[0;31m"
LIGHT_BLUE='\x1b[38;5;14m'
DARK_BLUE='\x1b[38;5;63m'
BLUE='\x1b[38;5;105m'
DARK_YELLOW='\x1b[38;5;178m'
PINK='\033[0;35m'
RESET_COLOR="\033[0m"

CLEAR_LINE="\033[1A\033[2K"

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

## MAIN LOGIC
# get temporal package npx directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGE_DIR="$(dirname "$DIR")/devkit-init"

# handle user cancel with SIGINT (Ctrl + C)
sigint_handler() {
    echo -e "$CLEAR_LINE /n"
    echo -e "${CLEAR_LINE}❌ Operation cancelled" >&2
    exit 1
}
trap 'sigint_handler' SIGINT


# function to print the prompt and handle user input
get_project_dir() {
    echo -ne "${RED}?${RESET_COLOR} Project name: "
    read -r input
    
    if [ "$input" = "" ]; then
        project_dir="my-app"
    else
        project_dir="$input"
    fi
}
get_project_dir

outputDirectory=$project_dir 
echo -e "${CLEAR_LINE}✔️ Creating project: $outputDirectory"
echo "🦁 Select Technologies:"

# select techs
is_tech() {
    local tech="$1"
    echo -ne "${RED}?${RESET_COLOR} ${tech}? ${GREY}yes / no${RESET_COLOR} "
    read -rp "" choice
    choice_lowercase=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    # check the user's choice
    case $choice_lowercase in
        y|yes|"") 
            tech_choice=true
            echo -e "${CLEAR_LINE}✔️  ${tech}"
            ;;
        n|no)
            if [ "${tech}" = "${LIGHT_BLUE}React${RESET_COLOR}" ]; then
                echo -e "${CLEAR_LINE}✔️  ${DARK_YELLOW}Javascript${RESET_COLOR}"
            else
                echo -e "${CLEAR_LINE}❌ ${tech}"
                tech_choice=false
            fi
            ;;
        *) 
            echo -e "${CLEAR_LINE}❌ ${tech}"
            echo -e "❌ Operation cancelled -> Invalid option"
            exit 0
            ;;
    esac
}

# React choice
is_tech "${LIGHT_BLUE}React${RESET_COLOR}"
is_react=$tech_choice

# TypeScript choice
is_tech "${DARK_BLUE}TypeScript${RESET_COLOR}"
is_typescript=$tech_choice

if [ "$is_react" = true ]; then
    # Tailwind choice
    is_tech "${BLUE}Tailwind${RESET_COLOR}"
    is_tailwind=$tech_choice
fi
# Sass choice
is_tech "${PINK}Sass${RESET_COLOR}"
is_sass=$tech_choice

progress_bar
mkdir "$outputDirectory" && cd "$outputDirectory" || exit 1


# FOLDERS
dist_folders=(
    "dist/js"
    "dist/css"
)

sass_folders=(
    "src/scss/base"
    "src/scss/components"
    "src/scss/layout"
    "src/scss/utils"
)

ts_folders=(
    "src/ts"
)

js_folders=(
    "src/js"
)

root_folders=(
    "public/favicon"
    "public/images"
)

progress_bar
# REACT
if [ "$is_react" = true ]; then
    if [ "$is_typescript" = true ]; then
        next_ts_flag="--ts"
    else
        next_ts_flag="--js"
    fi

    if [ "$is_tailwind" = true ]; then
        next_tw_flag="--tailwind"
    else
        next_tw_flag="--no-tailwind"
    fi
    cd ..
    pnpm create next-app@latest "$outputDirectory" ${next_ts_flag} ${next_tw_flag} --no-eslint --app --src-dir --import-alias default >/dev/null 2>&1
    progress_bar
    rm "$outputDirectory/next.config.mjs"
    rm -rf "$outputDirectory/.git"
    cd "$outputDirectory" || exit 1
else
    for folder in "${dist_folders[@]}" "${root_folders[@]}"; do
        mkdir -p "$folder"
    done
    pnpm init > /dev/null 2>&1
    pnpm install -D rollup >/dev/null 2>&1
    progress_bar
    touch rollup.config.js
fi

# TYPESCRIPT
if [[ "$is_typescript" = true && "$is_react" = false ]]; then
    for folder in "${ts_folders[@]}"; do
        mkdir -p "$folder"
        touch src/ts/main.ts
        progress_bar
    done
fi

if [[ "$is_typescript" = false && "$is_react" = false ]]; then
    for folder in "${js_folders[@]}"; do
        mkdir -p "$folder"
        touch src/js/main.js
        progress_bar
    done
fi

# SASS
if [ "$is_sass" = true ]; then
    pnpm install -D sass >/dev/null 2>&1
    pnpm install -D node-sass >/dev/null 2>&1
    pnpm install -D nodemon >/dev/null 2>&1
fi
for folder in "${sass_folders[@]}"; do
    mkdir -p "$folder"
done
progress_bar

# PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1
if [ "$is_typescript" = true ]; then
    pnpm install -D typescript@latest eslint-config-standard-with-typescript@latest >/dev/null 2>&1
    progress_bar
else
    pnpm install -D eslint-config-standard@latest >/dev/null 2>&1
    progress_bar
fi

pnpm install -D eslint-plugin-react@latest @typescript-eslint/eslint-plugin@^6.4.0 eslint@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
progress_bar
pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
pnpm install -D eslint-config-prettier >/dev/null 2>&1
progress_bar
touch .eslintrc.json

if [ "$is_react" = true ]; then
    pnpm install -D eslint-config-next@latest >/dev/null 2>&1
fi

# TEMPLATES
cd ..
progress_bar
# VANILLA template || REACT template
if [ "$is_react" = false ]; then
    node "$PACKAGE_DIR/scripts/vanillaInit.js" "$outputDirectory"
elif [[ "$is_react" = true && "$is_typescript" = true ]]; then
    node "$PACKAGE_DIR/scripts/tsReactInit.js" "$outputDirectory"
elif [[ "$is_react" = true && "$is_typescript" = false ]]; then
    node "$PACKAGE_DIR/scripts/reactInit.js" "$outputDirectory"
    rm "$outputDirectory"/src/app/page.js "$outputDirectory"/src/app/layout.js
fi

# TYPESCRIPT template
if [[ "$is_typescript" = true && "$is_react" = false ]]; then
    node "$PACKAGE_DIR/scripts/typescriptInit.js" "$outputDirectory"
fi
progress_bar

# CLEANING
if [ "$is_react" = true ]; then
    rm "$outputDirectory"/public/next.svg "$outputDirectory"/public/vercel.svg "$outputDirectory"/src/app/favicon.ico "$outputDirectory"/src/app/globals.css
fi

if [ "$is_sass" = false ]; then
    rm -rf "$outputDirectory"/src/scss
    mv "$outputDirectory"/src/app/globals.scss "$outputDirectory"/src/app/globals.css
    sed -i 's/globals\.scss/globals\.css/' "$outputDirectory"/src/app/layout.jsx
fi
progress_bar

# Initial commit
cd "$outputDirectory" || exit 1
git init >/dev/null 2>&1
git add . >/dev/null 2>&1
git commit -m 'initial commit' >/dev/null 2>&1
progress_bar
echo -ne "${CLEAR_LINE}🦁 Process completed successfully 🦁"

# open Visual Studio Code
cd ..
code "$outputDirectory"
