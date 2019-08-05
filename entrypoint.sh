#!/bin/sh

if [ ! -f /mnt/cron.d/cron.conf ]; then
    echo "* * * * * echo 'Running'" > /mnt/cron.d/cron.conf
fi

ENV_VARS='$ENV_DOMAIN_NAME:$ENV_UPSTREAM_HOST:$ENV_SMTP_HOST';

envsubst "$ENV_VARS" \
    < /mnt/ssmtp.template \
    > /etc/ssmtp/ssmtp.conf

chmod 600 /mnt/cron.d/cron.conf
crontab /mnt/cron.d/cron.conf

exec "$@"