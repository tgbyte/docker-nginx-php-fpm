#!/bin/bash

for f in /entrypoint.d/*.sh; do
    . $f
done

exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
