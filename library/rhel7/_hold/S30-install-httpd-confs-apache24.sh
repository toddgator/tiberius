#!/bin/bash
cd /tmp
su - sdi -c "cd /tmp;git clone git@github.thig.com:IT-Operations/thig-apache2.4-site-configs.git"
unalias cp &> /dev/null
cp -f /tmp/thig-apache2.4-site-configs/scripts/automate_install.sh /tmp
systemctl enable httpd.service
./automate_install.sh
mkdir -p /etc/httpd/conf.d/sites-enabled
chmod +xr /var/log/httpd/
chown -R apache:apache /etc/httpd/conf.d
