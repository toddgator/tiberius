#!/bin/bash
VERSION=1.0
. /etc/sdi/thig-settings

mkdir /tmp/check_mk
cd /tmp/check_mk

#Pull all contents of Check_MK latest dir
wget -r -np -nd -nH -R index.html* http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/check_mk/

rpm -i check-mk-agent-latest.rpm

#Preserve executable rights for mk_logwatch
chmod 755 check-mk-logwatch-latest

mv check-mk-logwatch-latest /usr/lib/check_mk_agent/plugins/mk_logwatch

mkdir /etc/check_mk/logwatch.d
if test -f "/opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/check_mk/${ROLE}_all.cfg"
  then
    ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/check_mk/${ROLE}_all.cfg /etc/check_mk/logwatch.d/
fi

if test -f "/opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/check_mk/${ROLE}_${ENVIRONMENT}.cfg"
  then
    ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/check_mk/${ROLE}_${ENVIRONMENT}.cfg /etc/check_mk/logwatch.d/
fi

touch /etc/check_mk/logwatch.cfg

#Clean up
cd /tmp && rm -rf /tmp/check_mk

#Added check_mk_agent bin alteration from RHEL6 kickstart

sed -i "s/df -PTl/df -PT/g" /usr/bin/check_mk_agent
sed -i "s/excludefs=\"-x smbfs -x cifs -x iso9660 -x udf -x nfsv4 -x nfs -x mvfs -x zfs -x prl_fs\"/excludefs=\"-x tmpfs -x iso9660 -x udf -x mvfs -x zfs\"/g" /usr/bin/check_mk_agent

#Reset default Check_MK library dir to /usr/lib...

sed -i 's|/usr/share/check-mk-agent|/usr/lib/check_mk_agent|g' /usr/bin/check_mk_agent
#sed -i 's|/etc/check-mk-agent|/etc/check_mk|g'
