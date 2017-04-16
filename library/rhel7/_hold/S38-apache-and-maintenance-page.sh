#!/bin/bash
. /etc/sdi/thig-settings
yum -y install httpd openssl mod_ssl
chkconfig httpd on
mv /etc/httpd/conf.d/php.conf /etc/httpd/conf.d/php.conf.disabled
cp -parf /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/* /var/www/html/

mkdir /etc/httpd/conf.d/includes
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/httpd.conf /etc/httpd/conf/
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/maintenancepage.conf /etc/httpd/conf.d/
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/thig_ssl.conf /etc/httpd/conf.d/includes
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/forceSSL.conf /etc/httpd/conf.d/includes
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/security_mitigations.conf /etc/httpd/conf.d/includes

rm -f /etc/httpd/conf.d/README
rm -f /etc/httpd/conf.d/ssl.conf  
rm -f /etc/httpd/conf.d/welcome.conf

mkdir /etc/httpd/certs

cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/thig.com.Jun2015-Jun2018.crt /etc/httpd/certs
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/thig.com.Jun2015-Jun2018.key /etc/httpd/certs
ln -s /etc/httpd/certs/thig.com.Jun2015-Jun2018.crt /etc/httpd/certs/thig.com.crt
ln -s /etc/httpd/certs/thig.com.Jun2015-Jun2018.key /etc/httpd/certs/thig.com.key
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/gd_bundle.crt /etc/httpd/certs
sed -i "s/sed-me-to-ip/$(ip a s eth0 | awk -F"[/ ]+" '/inet / {print $3}'|head -1)/g" /etc/httpd/conf/httpd.conf
service httpd restart
