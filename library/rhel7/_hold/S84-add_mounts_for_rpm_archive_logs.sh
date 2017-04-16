#!/bin/bash
. /etc/sdi/thig-settings
tmp_hostname=$(hostname -s)
mkdir /mnt/archive.logs
ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/samba/rpm_log_archive_credentials /etc/samba/
echo "//applogs.thig.com/app_logs/archive/prod.rpm${tmp_hostname:9:2} /mnt/archive.logs cifs rw,credfile=/etc/samba/rpm_log_archive_credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
