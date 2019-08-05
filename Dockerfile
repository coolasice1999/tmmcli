FROM alpine

RUN apk add --no-cache gettext docker

COPY ./entrypoint.sh /mnt/entrypoint.sh

RUN chmod +x /mnt/entrypoint.sh

ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "0"] 
