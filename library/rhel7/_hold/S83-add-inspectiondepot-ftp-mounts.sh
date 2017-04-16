#!/bin/bash
. /etc/sdi/thig-settings
mkdir -p /mnt/ftp.thig.com/idepot
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/inspectiondepot_ftp_submissions /mnt/ftp.thig.com/idepot cifs defaults,_netdev,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0" >>  /etc/fstab
