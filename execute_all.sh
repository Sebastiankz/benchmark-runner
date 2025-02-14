#!/bin/sh
echo "Lenguaje | Tiempo (ms)" > results.txt

for lang in c go javascript python rust
do
    echo "Ejecutando $lang"
    docker build -t "$lang-benchmark" "./$lang"  
    tiempo=$(docker run --rm "$lang-benchmark")  
    echo "$lang | $tiempo ms" >> results.txt
done

cat results.txt