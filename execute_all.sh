#!/bin/sh

# Clonar el repositorio de los programas
git clone https://github.com/Sebastiankz/benchmark.git
cd benchmark

echo "Lenguaje | Tiempo (ms)" > results.txt

for lang in c go java javascript python 
do
    echo "🔹 Ejecutando $lang..."
    
    case $lang in
        c)
            apk add --no-cache gcc musl-dev
            start=$(date +%s%3N)
            gcc c/main.c -o main && ./main
            end=$(date +%s%3N)
            ;;
        go)
            apk add --no-cache go
            start=$(date +%s%3N)
            go run go/main.go
            end=$(date +%s%3N)
            ;;
        java)
            apk add --no-cache openjdk11
            start=$(date +%s%3N)
            javac java/Main.java && java Main
            end=$(date +%s%3N)
            ;;
        javascript)
            apk add --no-cache nodejs
            start=$(date +%s%3N)
            node javascript/main.js
            end=$(date +%s%3N)
            ;;
        python)
            apk add --no-cache python3
            start=$(date +%s%3N)
            python3 python/main.py
            end=$(date +%s%3N)
            ;;
    esac
    
    tiempo=$((end - start))
    echo "$lang | $tiempo ms" >> results.txt
    echo "✅ $lang: $tiempo ms"
done

cat results.txt
