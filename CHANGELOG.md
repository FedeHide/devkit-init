# Changelog

## [v0.3.0](https://github.com/FedeHide/dev-init/releases/tag/v0.3.0) (2024-02-16)

### Updates

* **update:** sass breakpoints, mixins and reset; add index.html OG and robots meta tags ([3c76a04](https://github.com/FedeHide/dev-init/commit/3c76a046328425e8eb05714801e091157733cee9))

* **update:** readme.md ([0c0f089](https://github.com/FedeHide/dev-init/commit/0c0f089ec526f0389320786d1abe7231f0134d2a#diff-b335630551682c19a781afebcf4d07bf978fb1f8ac04c6bf87428ed5106870f5))

### Performance Improvements

* **refactor:** change init.js script exec. line, improving dependencies ([a1e814d](https://github.com/FedeHide/dev-init/commit/a1e814d15a53601c508a6e3c4114a568ef972d2a))

## [v0.2.0](https://github.com/FedeHide/dev-init/releases/tag/v0.2.0) (2024-02-09)

### Features

* **add:** CONTRIBUTING template and update gitignore ([d2fb27f](https://github.com/FedeHide/dev-init/commit/d2fb27fda9e23924e8ba54cd74f464782ddce112))

* **add:** SCSS initial files and content ([9c28ba1](https://github.com/FedeHide/dev-init/commit/9c28ba15dd7e7c3a21d9629f5611b10b6f15caf8))

### Performance Improvements

* **optimization:** merge tsconfig update into init file ([d15dfba](https://github.com/FedeHide/dev-init/commit/d15dfba858ad26c44e04a3793ceb4945cf1c6518))

* **optimization** of the package.json scripts, remove default dev-dependencies ([c240dc3](https://github.com/FedeHide/dev-init/commit/c240dc3c5a042d4776d67acb62bbbeada66d43b4))

* **migrate:**  now creating directories, git initial commit and run build dependencies from shell script ([4615e37](https://github.com/FedeHide/dev-init/commit/4615e37805897ea421588cf068a456233951243a))

## [v0.1.0](https://github.com/FedeHide/dev-init/releases/tag/v0.1.0) (2024-02-08)

### Features

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