const fs = require('node:fs').promises;
const path = require('node:path');

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
            // core files
            { fileName: '/src/app/layout.tsx', content: templateData['layout.tsx'] },
            { fileName: '/src/app/page.tsx', content: templateData['page.tsx'] },
            { fileName: '/src/middleware.ts', content: templateData['middleware.ts'] },
            { fileName: 'src/lib/corsMiddleware.ts', content: templateData['corsMiddleware.ts'] },
            { fileName: '/src/lib/LogExecEnv.ts', content: templateData['LogExecEnv.ts'] },
            { fileName: '/src/hooks/useScrollToRef.ts', content: templateData['useScrollToRef.ts'] },
            { fileName: 'CONTRIBUTING.md', content: templateData['CONTRIBUTING.md'] },
            { fileName: 'CODE_OF_CONDUCT.md', content: templateData['CODE_OF_CONDUCT.md'] },
            { fileName: 'LICENSE', content: templateData['LICENSE'] },
            { fileName: 'CHANGELOG.md', content: templateData['CHANGELOG.md'] },
            { fileName: 'README.md', content: templateData['README.md'] },
            // css files
            { fileName: '/src/styles/globals.css', content: templateData['globals.css'] },
            { fileName: '/src/styles/base/reset.css', content: templateData['reset.css'] },
            { fileName: '/src/styles/base/index.css', content: templateData['base.index.css'] },
            { fileName: '/src/app/page.module.css', content: templateData['page.module.css'] },
            // config files
            { fileName: 'next.config.mjs', content: templateData['next.config.mjs'] },
            { fileName: 'next-sitemap.config.js', content: templateData['next-sitemap.config.js'] },
            { fileName: 'package.json', content: templateData['package.json'] },
            { fileName: '.eslintrc.json', content: templateData['.eslintrc.json'] },
            { fileName: '.prettierignore', content: templateData['.prettierignore'] },
            { fileName: '.prettierrc.json', content: templateData['.prettierrc.json'] },
            { fileName: '.gitignore', content: templateData['.gitignore'] },
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
