#!/bin/bash

# Directorio donde se clonará el repositorio de los lenguajes
BENCHMARK_DIR="/benchmark"

# Si el repositorio con los códigos no está clonado, clonarlo
if [ ! -d "$BENCHMARK_DIR" ]; then
    git clone https://github.com/TU_USUARIO/benchmark.git "$BENCHMARK_DIR"
fi

# Moverse al directorio clonado
cd "$BENCHMARK_DIR" || exit 1

echo "Lenguaje | Tiempo (ms)"
echo "----------------------"

# Recorrer carpetas de lenguajes
for dir in */; do
  if [ -d "$dir" ]; then
    LENGUAJE=$(basename "$dir")
    IMG_NAME=$(echo "$LENGUAJE" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]')

    echo "🔹 Ejecutando $LENGUAJE..."

    # Construir la imagen Docker
    docker build -t "${IMG_NAME}-benchmark" "$dir"

    # Ejecutar el contenedor y capturar tiempo
    TIEMPO=$(docker run --rm "${IMG_NAME}-benchmark" | tail -n 1)

    # Verificar que el tiempo es un número antes de imprimir
    if [[ $TIEMPO =~ ^[0-9]+$ ]]; then
      echo "$LENGUAJE | $TIEMPO ms"
    else
      echo "❌ Error en $LENGUAJE: No se obtuvo un tiempo válido"
    fi
  fi
done
