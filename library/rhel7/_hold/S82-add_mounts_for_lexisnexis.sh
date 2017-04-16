#!/bin/bash
. /etc/sdi/thig-settings
mkdir -p /mnt/cifs/batch_processing/lexisnexis/eliens
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/lexisnexis/eliens           /mnt/cifs/batch_processing/lexisnexis/eliens cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/linuxsmb_dev_credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
ln -s /opt/sdi/thig-application-configs-global/credentials/samba/linuxsmb_dev_credentials /etc/samba/

