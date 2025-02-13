FROM docker:dind
RUN apk add --no-cache git bash
COPY execute_all.sh /run_all.sh
RUN chmod +x /execute_all.sh
CMD ["/execute_all.sh"]