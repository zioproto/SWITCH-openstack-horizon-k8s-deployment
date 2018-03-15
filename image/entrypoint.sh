#! /usr/bin/env bash

#set -xeuo pipefail
set -x
trap stop INT TERM

sed -i "s/%REDIS_MASTER_SERVICE_HOST%/${REDIS_MASTER_SERVICE_HOST}/" /etc/openstack-dashboard/local_settings.py

sed -i "s!%OPENSTACK_KEYSTONE_URL%!${OPENSTACK_KEYSTONE_URL}!" /etc/openstack-dashboard/local_settings.py

mkdir /etc/openstack-dashboard/secret/
cp /etc/openstack-dashboard/secretreadonly/.secret_key_store /etc/openstack-dashboard/secret/.secret_key_store
/bin/chown horizon /etc/openstack-dashboard/secret/.secret_key_store
/bin/chmod 600 /etc/openstack-dashboard/secret/.secret_key_store
/usr/share/openstack-dashboard/manage.py collectstatic --noinput
/usr/share/openstack-dashboard/manage.py compress --force
. /etc/apache2/envvars
rm /var/run/apache2/apache2.pid > /dev/null 2>&1
exec /usr/sbin/apache2 -DFOREGROUND

