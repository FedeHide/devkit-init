const fs = require('fs').promises;
const path = require('path');

// Reads the output directory from the command line arguments.
const outputDirectory = process.argv[2];

// search templates directory
const currentDirectory = __dirname;
const suffixIndex = currentDirectory.lastIndexOf('/')
const suffixPath = currentDirectory.substring(suffixIndex)
const templatePath = currentDirectory + suffixPath + ".json"

if (!outputDirectory) {
    console.error('Error: It is required to specify an output directory.');
    process.exit(1);
}

async function createFiles(outputDirectory) {
    try {
        // To check if the output directory exists, oterwise, create it
        await fs.mkdir(outputDirectory, { recursive: true });

        // Read the content of the file template.json and parse it.
        const data = await fs.readFile(`${templatePath}`, 'utf8');
        const templateData = JSON.parse(data);

        const files = [
            // template files
            { fileName: '/src/main.tsx', content: templateData['main.tsx'] },
            { fileName: '/src/App.tsx', content: templateData['App.tsx'] },
            { fileName: 'index.html', content: templateData['index.html'] },
            { fileName: '/favicon/manifest.json', content: templateData['manifest.json'] },
            { fileName: '/public/robots.txt', content: templateData['robots.txt'] },
            // SASS files
            { fileName: '/src/scss/main.scss', content: templateData['main.scss'] },
            { fileName: '/src/scss/base/_breakpoints.scss', content: templateData['breakpoints.scss'] },
            { fileName: '/src/scss/base/_functions.scss', content: templateData['functions.scss'] },
            { fileName: '/src/scss/base/_index.scss', content: templateData['base_index.scss'] },
            { fileName: '/src/scss/base/_mixins.scss', content: templateData['mixins.scss'] },
            { fileName: '/src/scss/base/_reset.scss', content: templateData['reset.scss'] },
            { fileName: '/src/scss/layout/_index.scss', content: templateData['layout_index.scss'] },
            { fileName: '/src/scss/utils/_index.scss', content: templateData['utils_index.scss'] },
            // common files
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
        ];

        // Process each file in parallel
        await Promise.all(files.map(async ({ fileName, content }) => {
            try {
                const filePath = path.join(outputDirectory, fileName);
                // If it's package.json, merge the content with existing content if it exists
                if (fileName === 'package.json') {
                    let existingContent = {};
                    try {
                        existingContent = JSON.parse(await fs.readFile(filePath, 'utf8'));
                    } catch (err) {
                        console.log(`Creating ${fileName} as it doesn't exist.`);
                    }
                    const mergedContent = { ...existingContent, ...content };
                    await fs.writeFile(filePath, JSON.stringify(mergedContent, null, 4), 'utf8');
                } else {
                    // Otherwise, write the content to the file
                    const fileContent = typeof content === 'object' ? JSON.stringify(content, null, 4) : content;
                    await fs.writeFile(filePath, fileContent, 'utf8');
                }
            } catch (err) {
                console.error(`Error writing to ${fileName}:`, err);
            }
        }));

    } catch (err) {
        console.error('Error creating the output directory or reading the template.json file.:', err);
    }
}

createFiles(outputDirectory);
