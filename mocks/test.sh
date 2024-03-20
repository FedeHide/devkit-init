#!/bin/bash

# FOLDERS
# shellcheck disable=SC2034
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

# FLAGS
next_ts_flag="--ts"
next_ts_flag="--js"
next_tw_flag="--tailwind"
next_tw_flag="--no-tailwind"

# VANILLA
pnpm init > /dev/null 2>&1
pnpm install -D rollup >/dev/null 2>&1
touch rollup.config.js

# VANILLA TS
touch src/ts/main.ts

# VANILLA JS
touch src/js/main.js

# SASS
pnpm install -D sass >/dev/null 2>&1
pnpm install -D nodemon >/dev/null 2>&1



# PRETTIER & ESLINT RULES
pnpm install -D prettier >/dev/null 2>&1

# TS 
pnpm install -D typescript@latest eslint@latest @typescript-eslint/eslint-plugin@^6.4.0 eslint-config-love@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
# TS REACT
pnpm install -D typescript@latest eslint@latest @typescript-eslint/eslint-plugin@^6.4.0 eslint-config-love@latest eslint-plugin-react@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1

# JS 
pnpm install -D eslint@latest eslint-config-standard@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1
# JS REACT
pnpm install -D eslint@latest eslint-config-standard@latest eslint-plugin-react@latest eslint-plugin-import@latest eslint-plugin-n@latest eslint-plugin-promise@latest >/dev/null 2>&1

# NEXTJS
pnpm install -D eslint-config-next@latest >/dev/null 2>&1

pnpm install -D eslint-plugin-prettier@latest >/dev/null 2>&1
pnpm install -D eslint-config-prettier >/dev/null 2>&1
