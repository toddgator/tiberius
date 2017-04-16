#!/bin/bash

npm install -g maildev

echo "
[Unit]
Description=Mailcatcher Start/Stop Script
After=network-online.target httpd.service 

[Service]
Type=simple
ExecStart=/bin/maildev -w 1080 --outgoing-host mail.thig.com --outgoing-port 25

[Install]
WantedBy=multi-user.target" > /usr/lib/systemd/system/sdi.maildev.service

systemctl daemon-reload
systemctl enable sdi.maildev.service


#yum -y install ruby ruby-devel rubygems sqlite-devel
#useradd -d /opt/mailcatcher mailcatcher

#gem install mailcatcher
#ln -s /etc/httpd/conf.d/sites-available/mailcatcher_hosts.conf /etc/httpd/conf.d/sites-enabled/
#ln -s /opt/sdi/sdi_service_scripts/init/mailcatcher-el7 /etc/init.d/sdi.mailcatcher

#echo "
#[Unit]
#Description=Mailcatcher Start/Stop Script
#After=network-online.target httpd.service

#[Service]
#Type=simple
#ExecStart=/bin/su - mailcatcher -c \"nohup mailcatcher --no-quit --smtp-ip=0.0.0.0\"
#ExecStop=/etc/init.d/sdi.mailcatcher stop

#[Install]
#WantedBy=multi-user.target" > /usr/lib/systemd/system/sdi.mailcatcher.service

#systemctl daemon-reload
#systemctl enable sdi.mailcatcher.service
