FROM docker:dind

# Instalar dependencias necesarias
RUN apk add --no-cache git bash

# Configurar BuildKit y buildx
ENV DOCKER_BUILDKIT=1
RUN mkdir -p /etc/docker && \
    echo '{"features": {"buildkit": true}}' > /etc/docker/daemon.json

WORKDIR /app
COPY execute_all.sh .
RUN chmod +x execute_all.sh

CMD ["dockerd-entrypoint.sh", "bash", "./execute_all.sh"]