const fs = require('fs').promises;
const path = require('path');
const { execSync } = require('child_process');

// Reads the output directory from the command line arguments.
const outputDirectory = process.argv[2];

// Ejecutar el comando para encontrar la carpeta
const command = 'find ~/.npm/_npx -type d -name "devkit-init" | grep -i "devkit-init"';
const tempPackagePath = execSync(command, { encoding: 'utf-8' });
const cleanedTempPackagePath = tempPackagePath.trim();

if (!outputDirectory) {
    console.error('Error: It is required to specify an output directory.');
    process.exit(1);
}

async function createFiles(outputDirectory) {
    try {
        // To check if the output directory exists, oterwise, create it
        await fs.mkdir(outputDirectory, { recursive: true });

        // Read the content of the file template.json and parse it.
        const data = await fs.readFile(`${cleanedTempPackagePath}/templates/typescriptTemplate.json`, 'utf8');
        const templateData = JSON.parse(data);

        const files = [
            { fileName: 'package.json', content: templateData['package.json'] },
            { fileName: '.eslintrc.json', content: templateData['.eslintrc.json'] },
            { fileName: 'tsconfig.json', content: templateData['tsconfig.json'] }
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