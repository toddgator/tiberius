#!/usr/bin/env bash

. /etc/sdi/thig-settings
cd /etc/samba
ln -sf /opt/sdi/thig-application-configs-global/roles/flgnv/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/applogs_${ENVIRONMENT}_credentials
echo "$(date) /opt/sdi/thig-application-configs-global/roles/flgnv/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/applogs_${ENVIRONMENT}_credentials symlinked to /etc/samba/applogs_${ENVIRONMENT}_credentials" >> /var/log/thig_symlinks.log
mkdir /mnt/archive.logs
echo "//applogs.thig.com/app_logs/${ENVIRONMENT}/${ENVIRONMENT}.${ROLE}${HOSTNAME:9:2} /mnt/archive.logs cifs rw,credfile=/etc/samba/applogs_${ENVIRONMENT}_credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
