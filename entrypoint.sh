#!/bin/sh

if [ ! -f /mnt/cron.conf ]; then
    echo "0 5 * * * /config/tinyMediaManagerCMD.sh -updateMovies -updateTv -scrapeNew" > /mnt/cron.d/cron.conf
fi

chmod 600 /mnt/cron.conf
crontab /mnt/cron.conf

exec "$@"
