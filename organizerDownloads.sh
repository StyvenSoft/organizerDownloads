#!/bin/bash

# Ruta de la carpeta de descargas
downloads_folder="C:/Users/s7eveen/Downloads/descargas"

# Extensiones definidas a carpetas
declare -A extension_folders=(
    ["jpg"]="Imágenes"
    ["png"]="Imágenes"
    ["doc"]="Documentos/Archivos Word"
    ["docx"]="Documentos/Archivos Word"
    ["xls"]="Documentos/Archivos Excel"
    ["xlsx"]="Documentos/Archivos Excel"
    ["ppt"]="Documentos/Archivos PowerPoint"
    ["pptx"]="Documentos/Archivos PowerPoint"
    ["pdf"]="Documentos/Archivos PDF"
    ["mp3"]="Música"
    ["mp4"]="Videos"
)

# Función para organizar un archivo en la carpeta adecuada
organize_file() {
    file="$1"
    extension="${file##*.}"

    folder="${extension_folders[$extension]}"
    if [[ -z "$folder" ]]; then
        folder="Otros"
    fi

    if [[ ! -d "$downloads_folder/$folder" ]]; then
        mkdir -p "$downloads_folder/$folder"
    fi

    mv "$downloads_folder/$file" "$downloads_folder/$folder"
    echo "Archivo '$file' movido a '$folder'"
}

# Recorremos los archivos en la carpeta de descargas
for file in "$downloads_folder"/*; do
    if [[ -f "$file" ]]; then
        organize_file "$(basename "$file")"
    fi
done

echo "Organización de archivos completa!"
