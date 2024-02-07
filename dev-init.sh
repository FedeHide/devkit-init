#!/bin/bash

# Verifica que se haya proporcionado un directorio de salida como argumento
if [ -z "$1" ]; then
    echo "Error: Se requiere especificar un directorio de salida."
    exit 1
fi

outputDirectory="$1" # Asigna el primer argumento a la variable outputDirectory

# Ejecutar el script para crear los archivos en el directorio de salida especificado
node init.js "$outputDirectory"

# Esperar a que se cierre Visual Studio Code para continuar
read -p "Presiona Enter para continuar..."

# Ejecutar el script de inicialización de la plantilla en el directorio de salida especificado
(cd "$outputDirectory" && pnpm run template-init)

# Abrir Visual Studio Code
code "$outputDirectory"

# Mostrar mensaje al final
echo "El proceso ha finalizado 🦁"