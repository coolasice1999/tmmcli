#!/bin/sh

if [ ! -f /mnt/cron.conf ]; then
    echo "30 0 * * * /config/tinyMediaManagerCMD.sh -updateMovies -updateTv -scrapeNew" > /mnt/cron.conf
fi

chmod 600 /mnt/cron.conf
crontab /mnt/cron.conf

exec "$@"
