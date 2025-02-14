FROM docker:latest

RUN apk add --no-cache git bash

# Copiar el repositorio benchmark ya clonado
COPY benchmark /benchmark

COPY execute_all.sh /execute_all.sh
RUN chmod +x /execute_all.sh

CMD ["/execute_all.sh"]
