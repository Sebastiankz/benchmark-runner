FROM alpine:latest

# Instalar dependencias necesarias
RUN apk add --no-cache git bash docker-cli

# Crear directorio de trabajo
WORKDIR /app

# Copiar script de ejecución
COPY execute_all.sh .

# Dar permisos de ejecución
RUN chmod +x execute_all.sh

# Ejecutar el script
CMD ["bash", "./execute_all.sh"]
