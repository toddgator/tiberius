#!/bin/bash
. /etc/sdi/thig-settings
su - sdi -c "cd /tmp;git clone git@github.thig.com:IT-Operations/thig-apache2-site-configs.git"
mkdir /etc/httpd/certs
cp /tmp/thig-apache2-site-configs/certs/* /etc/httpd/certs
chown apache:apache /etc/httpd/certs
ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/haproxy.cfg /etc/haproxy/haproxy.cfg
echo "$(date) /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/haproxy.cfg symlinked to /etc/haproxy/haproxy.cfg" >> /var/log/thig_symlinks.log
mkdir /var/lib/haproxy
chown haproxy:haproxy /var/lib/haproxy


sed -i "s/#.ModLoad imudp/\$ModLoad imudp\n\$UDPServerAddress 127.0.0.1/g" /etc/rsyslog.conf
sed -i "s/#.UDPServerRun 514/\$UDPServerRun 514/g" /etc/rsyslog.conf

service rsyslog restart

cat << EOF >> /etc/rsyslog.d/S50-haproxy.conf
if ($programname == 'haproxy') then -/var/log/haproxy.log
EOF
