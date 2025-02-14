# Permite ejecutar un contenedor de Docker dentro de otro contenedor de Docker
FROM docker:dind

# Instala git
RUN apk add --no-cache git

# Directorio de trabajo
WORKDIR /benchmark

# Clona el repositorio
RUN git clone https://github.com/Sebastiankz/benchmark.git .

# Copia el script de ejecución y le da permisos
COPY execute_all.sh /execute_all.sh
RUN chmod +x /execute_all.sh

# Usar ENTRYPOINT en lugar de CMD
ENTRYPOINT ["/execute_all.sh"]