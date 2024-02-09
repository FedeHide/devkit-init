const fs = require('fs').promises;
const path = require('path');

// Reads the output directory from the command line arguments.
const outputDirectory = process.argv[2];

if (!outputDirectory) {
    console.error('Error: It is required to specify an output directory.');
    process.exit(1);
}

async function createFiles(outputDirectory) {
    try {
        // To check if the output directory exists, oterwise, create it
        await fs.mkdir(outputDirectory, { recursive: true });

        // Read the content of the file template.json and parse it.
        const data = await fs.readFile('template.json', 'utf8');
        const templateData = JSON.parse(data);

        const files = [
            { fileName: 'package.json', content: templateData['package.json'] },
            { fileName: '.eslintignore', content: templateData['.eslintignore'] },
            { fileName: '.eslintrc.json', content: templateData['.eslintrc.json'] },
            { fileName: '.prettierignore', content: templateData['.prettierignore'] },
            { fileName: '.prettierrc.json', content: templateData['.prettierrc.json'] },
            { fileName: 'CONTRIBUTING.md', content: templateData['CONTRIBUTING.md'] },
            { fileName: 'CODE_OF_CONDUCT.md', content: templateData['CODE_OF_CONDUCT.md'] },
            { fileName: 'LICENSE', content: templateData['LICENSE'] },
            { fileName: '.gitignore', content: templateData['.gitignore'] },
            { fileName: 'CHANGELOG.md', content: templateData['CHANGELOG.md'] },
            { fileName: 'README.md', content: templateData['README.md'] },
            { fileName: '/src/scss/main.scss', content: templateData['main.scss'] },
            { fileName: '/src/scss/base/_breakpoints.scss', content: templateData['breakpoints.scss'] },
            { fileName: '/src/scss/base/_colors.scss', content: templateData['colors.scss'] },
            { fileName: '/src/scss/base/_functions.scss', content: templateData['functions.scss'] },
            { fileName: '/src/scss/base/_index.scss', content: templateData['base_index.scss'] },
            { fileName: '/src/scss/base/_mixins.scss', content: templateData['mixins.scss'] },
            { fileName: '/src/scss/base/_reset.scss', content: templateData['reset.scss'] },
            { fileName: '/src/scss/base/_typography.scss', content: templateData['typography.scss'] },
            { fileName: '/src/scss/components/_index.scss', content: templateData['components_index.scss'] },
            { fileName: '/src/scss/layout/_index.scss', content: templateData['layout_index.scss'] },
            { fileName: '/src/scss/utils/_index.scss', content: templateData['utils_index.scss'] },
            { fileName: 'index.html', content: templateData['index.html'] }
        ];

        // Process each file in parallel
        await Promise.all(files.map(async ({ fileName, content }) => {
            try {
                const fileContent = typeof content === 'object' ? JSON.stringify(content, null, 4) : content;
                const filePath = path.join(outputDirectory, fileName);
                await fs.writeFile(filePath, fileContent, 'utf8');
                console.log(`The file ${filePath} has been created successfully..`);
            } catch (err) {
                console.error(`Error writing to ${fileName}:`, err);
            }
        }));

        console.log('All files have been created successfully 🚀');

        // Copy the update-tsconfig.mjs file to the output directory
        // const sourceFilePath = 'update-tsconfig.mjs';
        // const destinationFilePath = path.join(outputDirectory, sourceFilePath);
        // await fs.copyFile(sourceFilePath, destinationFilePath);
        // console.log(`The file ${sourceFilePath} has been copied to the output directory.`);

        // console.log('All files have been created successfully 🚀');

    } catch (err) {
        console.error('Error creating the output directory or reading the template.json file.:', err);
    }
}

const tsconfig = {
    compilerOptions: {
    target: 'es2022',
    module: 'ES6',
    rootDir: './src/ts',
    outDir: './dist/js',
    sourceMap: true,
    removeComments: true,
    noEmitOnError: false,
    esModuleInterop: true,
    forceConsistentCasingInFileNames: true,
    strict: true,
    noImplicitAny: true,
    skipLibCheck: true
    }
};

const tsconfigPath = 'tsconfig.json';

async function updateTSConfig() {
    try {
    // Write the modified content back to tsconfig.json
        await fs.writeFile(tsconfigPath, JSON.stringify(tsconfig, null, 4));
        console.log('tsconfig.json successfully updated.');
    } catch (error) {
        console.error('Error updating tsconfig.json:', error);
    }
}

createFiles(outputDirectory);
updateTSConfig();
