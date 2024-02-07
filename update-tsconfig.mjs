import { writeFile } from 'fs/promises';

// Definir la configuración deseada para tsconfig.json
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

// Ruta al archivo tsconfig.json
const tsconfigPath = './tsconfig.json';

async function updateTSConfig() {
    try {
    // Escribe el contenido modificado de vuelta a tsconfig.json
        await writeFile(tsconfigPath, JSON.stringify(tsconfig, null, 2));

    console.log('tsconfig.json actualizado con éxito.');
    } catch (error) {
    console.error('Error al actualizar tsconfig.json:', error);
    }
}

updateTSConfig();
