const fs = require('fs').promises;
const path = require('path');

async function createFiles(outputDirectory) {
    try {
        // Verificar si el directorio de salida existe, de lo contrario, crearlo
        await fs.mkdir(outputDirectory, { recursive: true });

        // Lee el contenido del archivo template.json
        const data = await fs.readFile('template.json', 'utf8');
        const templateData = JSON.parse(data);

        // Define una lista de archivos con su contenido
        const files = [
            { fileName: 'package.json', content: templateData['package.json'] },
            { fileName: '.eslintignore', content: templateData['.eslintignore'] },
            { fileName: '.eslintrc.json', content: templateData['.eslintrc.json'] },
            { fileName: '.prettierignore', content: templateData['.prettierignore'] },
            { fileName: '.prettierrc.json', content: templateData['.prettierrc.json'] },
            { fileName: 'CODE_OF_CONDUCT.md', content: templateData['CODE_OF_CONDUCT.md'] },
            { fileName: 'LICENSE', content: templateData['LICENSE'] },
            { fileName: '.gitignore', content: templateData['.gitignore'] },
            { fileName: 'CHANGELOG.md', content: templateData['CHANGELOG.md'] },
            { fileName: 'README.md', content: templateData['README.md'] },
            { fileName: '_reset.scss', content: templateData['reset.scss'] },
            { fileName: 'index.html', content: templateData['index.html'] }
        ];

        // Procesa cada archivo en paralelo
        await Promise.all(files.map(async ({ fileName, content }) => {
            try {
                // Convertir el contenido a una cadena JSON antes de escribirlo
                const fileContent = typeof content === 'object' ? JSON.stringify(content, null, 4) : content;
                const filePath = path.join(outputDirectory, fileName); // Construye la ruta completa del archivo
                await fs.writeFile(filePath, fileContent, 'utf8');
                console.log(`Se ha creado el archivo ${filePath} correctamente.`);
            } catch (err) {
                console.error(`Error escribiendo en el archivo ${fileName}:`, err);
            }
        }));

        // Copiar el archivo update-tsconfig.mjs al directorio de salida
        const sourceFilePath = 'update-tsconfig.mjs';
        const destinationFilePath = path.join(outputDirectory, 'update-tsconfig.mjs');
        await fs.copyFile(sourceFilePath, destinationFilePath);
        console.log(`Se ha copiado el archivo ${sourceFilePath} al directorio de salida.`);

        console.log('Todos los archivos han sido creados correctamente 🚀');

    } catch (err) {
        console.error('Error creando el directorio de salida o leyendo el archivo template.json:', err);
    }
}

// Lee el directorio de salida de los argumentos de línea de comandos
const outputDirectory = process.argv[2];

if (!outputDirectory) {
    console.error('Error: Se requiere especificar un directorio de salida.');
    process.exit(1);
}

// Ejecutar la función para crear los archivos
createFiles(outputDirectory);
