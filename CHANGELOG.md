# Changelog

## [v0.1.0](https://github.com/FedeHide/dev-init/releases/tag/v0.1.0) (2024-02-08)

## Features

**commit:** ([0ad64c2](https://github.com/FedeHide/dev-init/commit/0ad64c25431c7f40c04849dfe6f1ddaf5b5cca5a))

### template.json

* **add:** .eslintignore - .eslintrc.json - .prettierignore - prettierrc.json - CODE_OF_CONDUCT.md - LICENSE - .gitignore - CHANGELOG.md - README.md - reset.scss - index.html.

### template.json --> package.json:

* **utils:** initial name, version, privacy, license and author.

* **scripts:** 
    * **lint:** eslint formatting.
    * **build-css:** SASS to CSS compilation.
    * **build-config:** update tsconfig.json, move _reset.scss file, delete unnecessary script, git initial commit.
    * **template-init:** add dev-dependencies; creating, moving and removing some folders.
    * **watch-css:** watch SASS files and run build-css.
    * **watch-ts:** watch TS files.

* **devDependencies:** TS, eslint, prettier, SASS, nodemon.