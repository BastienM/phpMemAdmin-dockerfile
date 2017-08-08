#!/bin/bash

USERNAME=${USERNAME:-admin}
PASSWORD=${PASSWORD:-admin}
CLUSTER_NAME=${CLUSTER_NAME:-localhost}
MEMCACHED_HOST=${MEMCACHED_HOST:-localhost}
MEMCACHED_PORT=${MEMCACHED_PORT:-11211}
TZ=${TZ:-Europe/Paris}

sed -i "s/%USERNAME%/${USERNAME}/g" /var/www/html/app/.config
sed -i "s/%PASSWORD%/${PASSWORD}/g" /var/www/html/app/.config
sed -i "s/%CLUSTER_NAME%/${CLUSTER_NAME}/g" /var/www/html/app/.config
sed -i "s/%MEMCACHED_HOST%/${MEMCACHED_HOST}/g" /var/www/html/app/.config
sed -i "s/%MEMCACHED_PORT%/${MEMCACHED_PORT}/g" /var/www/html/app/.config

echo "date.timezone=\"${TZ}\"" > /usr/local/etc/php/php.ini

exec "$@"
