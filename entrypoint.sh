#!/bin/sh

if [ ! -f /mnt/cron.d/cron.conf ]; then
    echo "0 5 * * * /config/tinyMediaManagerCMD.sh -updateMovies -updateTv -scrapeNew" > /mnt/cron.d/cron.conf
fi

chmod 600 /mnt/cron.d/cron.conf
crontab /mnt/cron.d/cron.conf

exec "$@"
