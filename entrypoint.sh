#!/bin/sh

if [ ! -f /mnt/cron.d/cron.conf ]; then
    echo "* * * * * echo 'Running'" > /mnt/cron.d/cron.conf
fi

chmod 600 /mnt/cron.d/cron.conf
crontab /mnt/cron.d/cron.conf

exec "$@"
