#!/bin/bash
. /etc/sdi/thig-settings
mkdir -p /mnt/cifs/UWAInspectionReturn
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/UWAInspectionReturn /mnt/cifs/UWAInspectionReturn cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0" >>  /etc/fstab
