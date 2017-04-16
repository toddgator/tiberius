#!/bin/bash
yum -y install php php-mysql php-gd php-xml
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php.ini
