#!/bin/bash

## VARIABLES
# COLOR VARIABLES
GREY="\033[1;30m"
RED="\033[0;31m"
LIGHT_BLUE='\x1b[38;5;14m'
DARK_BLUE='\x1b[38;5;63m'
BLUE='\x1b[38;5;105m'
DARK_YELLOW='\x1b[38;5;178m'
LIGHT_PURPLE='\033[1;35m'
LIGHT_GRAY='\033[0;37m'
RESET_COLOR="\033[0m"

CLEAR_LINE="\033[1A\033[2K"


## MAIN LOGIC
## GET temporary package npx directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export DIR


## HANDLE CANCEL from the user with SIGINT (Ctrl + C)
sigint_handler() {
    echo -e "$CLEAR_LINE /n"
    echo -e "${CLEAR_LINE}❌ Operation cancelled" >&2
    echo -e "\033[K"
    exit 1
}
trap 'sigint_handler' SIGINT


## function to print the prompt and handle user input
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
echo "🦁 Select Technologies 🦁"


## FUNCTION for tech selection
is_tech() {
    local option1="$1"
    local option2="$2"
    if [ "${option1}" = "${BLUE}Tailwind${RESET_COLOR}" ]; then
        echo -ne "${RED}?${RESET_COLOR} ${option1} ${GREY}(yes) / (no)${RESET_COLOR} > "
        read -rp "" choice
    else
        echo -ne "${RED}?${RESET_COLOR} ${GREY}(yes) ${RESET_COLOR}${option1} / ${GREY}(no)${RESET_COLOR} ${option2} > "
        read -rp "" choice
    fi
    choice_lowercase=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

    # check the user's choice
    case $choice_lowercase in
        (y|yes|"") 
            tech_choice=true
            echo -e "${CLEAR_LINE}✔️  ${option1}"
            ;;
        (n|no)
            if [ "${option1}" = "${BLUE}Tailwind${RESET_COLOR}" ]; then
                tech_choice=false
                echo -e "${CLEAR_LINE}❌ ${option1}"
            else
                tech_choice=false
                echo -e "${CLEAR_LINE}✔️  ${option2}"
            fi
            ;;
        (*) 
            echo -e "${CLEAR_LINE}❌ ${option1}"
            echo -e "❌ Operation cancelled -> Invalid option"
            exit 0
            ;;
    esac
}

## TECH CHOICES
# React choice
is_tech "${LIGHT_BLUE}React${RESET_COLOR}" "${DARK_YELLOW}Vanilla${RESET_COLOR}"
is_react=$tech_choice

# Nextjs or Vite choice
if [ "$is_react" = true ]; then
    is_tech "${LIGHT_GRAY}NextJS${RESET_COLOR}" "${LIGHT_PURPLE}Vite${RESET_COLOR}"
    is_next=$tech_choice
fi

# TypeScript choice
is_tech "${DARK_BLUE}TypeScript${RESET_COLOR}" "${DARK_YELLOW}Javascript${RESET_COLOR}"
is_typescript=$tech_choice

# Tailwind choice
if [ "$is_react" = true ]; then
    is_tech "${BLUE}Tailwind${RESET_COLOR}"
    is_tailwind=$tech_choice
fi



## BUILDING template path pushing sufix to directory
# React || Vanilla
if [ "$is_react" = true ]; then
    is_react="re"
else
    is_react="vn"
fi

# NextJs || Vite
if [ "$is_next" = true ]; then
    is_next="nx"
elif [ "$is_next" = false ]; then
    is_next="vi"
fi

# Typescript || Javascript
if [ "$is_typescript" = true ]; then
    is_typescript="ts"
else
    is_typescript="js"
fi

# Tailwind
if [ "$is_tailwind" = true ]; then
    is_tailwind="-tw"
else
    is_tailwind=""
fi


## RUN template
TEMPLATE_SH_DIR="$DIR/../devkit-init/templates/$is_react$is_next-$is_typescript$is_tailwind/$is_react$is_next-$is_typescript$is_tailwind.sh"
TEMPLATE_JS_DIR="$DIR/../devkit-init/templates/$is_react$is_next-$is_typescript$is_tailwind/$is_react$is_next-$is_typescript$is_tailwind.js"
export TEMPLATE_JS_DIR
export outputDirectory
bash "$TEMPLATE_SH_DIR"


## Initial commit
cd "$outputDirectory" || exit 1
git init >/dev/null 2>&1
git add . >/dev/null 2>&1
git commit -m 'initial commit' >/dev/null 2>&1


## open Visual Studio Code
cd ..
code "$outputDirectory"
echo -en "\r🦁 Process completed successfully 🦁 "
