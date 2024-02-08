import { writeFile } from 'fs/promises';

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

const tsconfigPath = './tsconfig.json';

async function updateTSConfig() {
    try {
    // Write the modified content back to tsconfig.json
        await writeFile(tsconfigPath, JSON.stringify(tsconfig, null, 4));
        console.log('tsconfig.json successfully updated.');
    } catch (error) {
        console.error('Error updating tsconfig.json:', error);
    }
}

updateTSConfig();
