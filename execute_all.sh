#!/bin/bash

# Entrar al directorio del benchmark
cd /benchmark || { echo "Error: No se encontró /benchmark"; exit 1; }

# Archivo de resultados
echo "Lenguaje | Tiempo (ms)" > results.txt

# Ejecutar los benchmarks por lenguaje
for dir in Lenguajes/*/; do
  if [ -d "$dir" ]; then
    LENGUAJE=$(basename "$dir")
    echo "🔹 Ejecutando $LENGUAJE..."
    
    # Construir imagen Docker del lenguaje
    docker build -t "${LENGUAJE//+/}-benchmark" "$dir"
    
    # Ejecutar y capturar el tiempo
    TIEMPO=$(docker run --rm "${LENGUAJE//+/}-benchmark")
    
    if [ -n "$TIEMPO" ]; then
      echo "$LENGUAJE | $TIEMPO ms" >> results.txt
      echo "$LENGUAJE: $TIEMPO ms"
    else
      echo "Error: No se obtuvo resultado en $LENGUAJE"
    fi
  fi
done

echo "Resultados guardados en results.txt"
