# Changelog

## [v1.2.2](https://github.com/FedeHide/dev-init/releases/tag/v1.2.2) (2024-03-13)

### Fix

* **hotfix:** add missing file templates y remove repeated one ([df095a6](https://github.com/FedeHide/devkit-init/commit/df095a64405659d77a9d9e1e79840abd06ed194d))

## [v1.2.1](https://github.com/FedeHide/dev-init/releases/tag/v1.2.1) (2024-03-13)

### Fix

* **hotfix:** typo testing variable name and null dependency output ([06dca03](https://github.com/FedeHide/devkit-init/commit/06dca039d76e4acf2c9e32df49f9dbfbc5ba1b74))

## [v1.2.0](https://github.com/FedeHide/dev-init/releases/tag/v1.2.0) (2024-03-13)

### Features

* **hotfix:** Improved the way of obtaining the temporary directory path of the package, as it was causing errors. Add some dependencies, change logic validation for those ([be912b8](https://github.com/FedeHide/devkit-init/commit/be912b80d24847079e54f121cf4c5659ad433038))

### Fix

* **hotfix:** rollup config input and output on vanilla template ([5b53698](https://github.com/FedeHide/devkit-init/commit/5b53698e2dc05260db94a4a9f5342daed0b50385))

* **hotfix:** eslint config and tsconfig outdir on typescript template ([8dce27f](https://github.com/FedeHide/devkit-init/commit/8dce27fae19f7e9edc99e7b7479be3972a2c587e))

* **hotfix:** prettier and eslint config, rootlayout.jsx remove metadata import on react template ([759d213](https://github.com/FedeHide/devkit-init/commit/759d213bc3a84536519fb93270dea907e3565343))

* **hotfix:** prettier and eslint rules on tsReact template ([dbc49e2](https://github.com/FedeHide/devkit-init/commit/dbc49e2f8cae89a46b4cdf4207b3907e1ffd3d05))

* **hotfix:** .js scripts -> Improved the way of obtaining the temporary directory path of the package, as it was causing errors. ([022f0e2](https://github.com/FedeHide/devkit-init/commit/022f0e2490d3277b0601335b896e82daa85d9970))

### Docs

* **docs:** add npmignore and update readme ([a5ac4b0](https://github.com/FedeHide/devkit-init/commit/a5ac4b0e00395196e4ecc14b1c9f751b7bb41fcd))

## [v1.1.0](https://github.com/FedeHide/dev-init/releases/tag/v1.1.0) (2024-03-12)

### Features

* **add:** integration with react and nextjs ([ad80bc1](https://github.com/FedeHide/devkit-init/commit/ad80bc171111eae6be34df5db42aa8ee7d6491f2))

* **add:** add sass mixins, adjust readme and html template ([da9ea19](https://github.com/FedeHide/dev-init/commit/da9ea194be45ddd92fa05534b8e4788d8b50f482))

## [v0.3.1](https://github.com/FedeHide/dev-init/releases/tag/v0.3.1) (2024-02-17)

### Fix

* **hotfix:** prevents package json to overwrite dev-dependencies, remove private package ([f537f17](https://github.com/FedeHide/dev-init/commit/f537f17496b9e8c00295fcf924cca11ead8431f8))

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