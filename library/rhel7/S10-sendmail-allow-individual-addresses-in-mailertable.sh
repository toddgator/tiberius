#!/bin/bash
# Taken from https://groups.google.com/forum/#!topic/comp.mail.sendmail/nJYw17-ik_I
yum -y install sendmail-cf
rm -f /etc/mail/sendmail.cf
unalias cp &> /dev/null
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/all/proto.m4 /usr/share/sendmail-cf/m4/proto.m4
cd /etc/mail
make all -C /etc/mail/
