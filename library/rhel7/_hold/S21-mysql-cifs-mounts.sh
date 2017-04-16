#!/bin/bash
mkdir -p /mnt/cifs/batchprocessor/mysql
cd /etc/samba
ln -s /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/iab/${ENVIRONMENT}/samba/docs_${ENVIRONMENT}_credentials
grep mysql /etc/fstab || echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/mysql           /mnt/cifs/batchprocessor/mysql cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/docs_${ENVIRONMENT}_credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
