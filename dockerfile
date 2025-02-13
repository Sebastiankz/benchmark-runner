FROM docker:dind

# Instalar dependencias adicionales necesarias
RUN apk add --no-cache git bash

# Configurar BuildKit
ENV DOCKER_BUILDKIT=1

# Crear directorio de trabajo
WORKDIR /app

# Copiar script de ejecución
COPY execute_all.sh .

# Dar permisos de ejecución
RUN chmod +x execute_all.sh

# Ejecutar el script
CMD ["bash", "./execute_all.sh"]