#!/bin/bash

# Ruta de la carpeta de descargas
downloads_folder="C:/Users/s7eveen/Downloads/descargas"

# Extensiones definidas a carpetas
declare -A extension_folders=(
    ["jpg"]="Imágenes"
    ["jpeg"]="Imágenes"
    ["png"]="Imágenes"
    ["webp"]="Imágenes"
    ["gif"]="Imágenes"
    ["doc"]="Documentos/Archivos Word"
    ["docx"]="Documentos/Archivos Word"
    ["xls"]="Documentos/Archivos Excel"
    ["xlsx"]="Documentos/Archivos Excel"
    ["ppt"]="Documentos/Archivos PowerPoint"
    ["pptx"]="Documentos/Archivos PowerPoint"
    ["pdf"]="Documentos/Archivos PDF"
    ["rar"]="Comprimidos"
    ["zip"]="Comprimidos"
    ["7z"]="Comprimidos"
    ["mp3"]="Música"
    ["ogg"]="Música"
    ["aac"]="Música"
    ["wma"]="Música"
    ["mp4"]="Videos"
    ["avi"]="Videos"
    ["mov"]="Videos"
    ["wmv"]="Videos"
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

    # Verificar si el archivo ya existe en la carpeta de destino
    new_file="$downloads_folder/$folder/$file"
    index=1
    while [[ -e "$new_file" ]]; do
        new_file="${downloads_folder}/${folder}/${file%.*}(${index}).${extension}"
        index=$((index + 1))
    done

    mv "$downloads_folder/$file" "$new_file"
    echo "Archivo '$file' movido a '$new_file'"
}

# Recorremos los archivos en la carpeta de descargas
for file in "$downloads_folder"/*; do
    if [[ -f "$file" ]]; then
        organize_file "$(basename "$file")"
    fi
done

echo "Organización de archivos completa!"
