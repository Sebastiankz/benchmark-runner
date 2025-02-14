FROM alpine:latest

# Instalar Git, Bash y dependencias necesarias
RUN apk add --no-cache git bash

# Copiar el script de ejecución
COPY execute_all.sh /execute_all.sh

# Dar permisos de ejecución al script
RUN chmod +x /execute_all.sh

# Ejecutar el script cuando inicie el contenedor
CMD ["/bin/sh", "/execute_all.sh"]
