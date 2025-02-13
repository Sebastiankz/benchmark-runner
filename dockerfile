# Permite ejecutar un contendor de Docker dentro de otro contenedor de Docker
FROM docker:dind

#instala git
RUN apk add --no-cache git

#directorios de trabajo
WORKDIR /benchmark

#clona el repositorio
RUN git clone https://github.com/Sebastiankz/benchmark.git .

#copiar el script de ejecución
COPY execute_all.sh /execute_all.sh

#permisos de ejecución
CMD ["sh", "/execute_all.sh"]
