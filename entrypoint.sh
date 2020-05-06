#!/bin/sh

if [ ! -f /mnt/cron.conf ]; then
#set time to 12:30AM run
    echo "$Cron_Timing /config/tinyMediaManagerCMD.sh -updateMovies -updateTv -scrapeUnscraped" > /mnt/cron.conf
fi
chmod 777 /config/*
chmod 600 /mnt/cron.conf
crontab /mnt/cron.conf

exec "$@"
