FROM docker:latest

# Instalar Git y Bash para ejecutar el script
RUN apk add --no-cache git bash

# Copiar el script de ejecución
COPY execute_all.sh /execute_all.sh

# Asignar permisos de ejecución
RUN chmod +x /execute_all.sh

# Ejecutar el script cuando el contenedor inicie
CMD ["/execute_all.sh"]
