#!/bin/bash
mkdir -p /var/www/html/maintenance_page
cp /opt/sdi/thig-apache2-site-configs/maintenance_page/* /var/www/html/maintenance_page/
chown apache:apache /var/www/html/maintenance_page/*

cd /etc/init.d
ln -s /opt/sdi/sdi_service_scripts/init/sdi.maintenance_page
