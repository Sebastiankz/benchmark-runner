#!/bin/bash

# Repositorio de soluciones
REPOSITORIO="https://github.com/Sebastiankz/benchmark.git"
DIRECTORIO="benchmark"

# Clonar el repositorio
git clone $REPOSITORIO $DIRECTORIO || { echo "Error clonando el repositorio"; exit 1; }

# Lenguajes y nombres de las imágenes
declare -A LANGUAGES
LANGUAGES=(
    ["go"]="go-app"
    ["rust"]="rust-app"
    ["javascript"]="node-app"
    ["python"]="python-app"
    ["c"]="c-app" 
)

# Crear carpeta de logs y archivo de resultados
mkdir -p logs
OUTPUT_FILE="execution_results.txt"
echo "Comparación de tiempos de ejecución" > $OUTPUT_FILE
echo "------------------------------------" >> $OUTPUT_FILE

for LANG in "${!LANGUAGES[@]}"; do
    IMAGE_NAME=${LANGUAGES[$LANG]}
    LANG_DIR="$DIRECTORIO/$LANG"  # Directorio correcto con la variable
    LOG_FILE="logs/$LANG/output.txt"

    echo "Construyendo imagen para $LANG..."
    (cd $LANG_DIR && docker build -t $IMAGE_NAME .) || { echo "Error al construir $LANG"; exit 1; }

    echo "Ejecutando contenedor para $LANG..."
    mkdir -p "logs/$LANG"

    # Redirigir la salida a output.txt
    docker run --rm $IMAGE_NAME | tee "$LOG_FILE"

    # Extraer el tiempo de ejecución
    EXEC_TIME=$(grep -Eo '[0-9]+ ms' "$LOG_FILE")
    echo "$LANG: $EXEC_TIME" | tee -a $OUTPUT_FILE
done

# Mostrar los resultados
echo "------------------------------------"
cat $OUTPUT_FILE
