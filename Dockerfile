FROM alpine

RUN apk add --no-cache ssmtp gettext docker

COPY ./entrypoint.sh /mnt/entrypoint.sh
COPY ./ssmtp.conf /mnt/ssmtp.template

RUN chmod +x /mnt/entrypoint.sh

ENTRYPOINT ["/mnt/entrypoint.sh"]
CMD ["/usr/sbin/crond", "-f", "-d", "0"] 
