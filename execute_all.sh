#!/bin/sh
echo "Lenguaje | Tiempo (ms)" > results.txt

for lang in c go javascript python rust
do
    if [ -d "./$lang" ] && [ -f "./$lang/Dockerfile" ]; then
        echo "Ejecutando $lang..."
        if docker build -t "$lang-benchmark" "./$lang"; then
            tiempo=$(docker run --rm "$lang-benchmark" 2>/dev/null)
            echo "$lang | $tiempo ms" >> results.txt
        else
            echo "$lang | Error en ejecución" >> results.txt
        fi
    else
        echo "$lang | Dockerfile no encontrado" >> results.txt
    fi
done

cat results.txt
