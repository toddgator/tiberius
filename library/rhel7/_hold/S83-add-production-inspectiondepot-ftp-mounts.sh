#!/bin/bash
. /etc/sdi/thig-settings
mkdir -p /mnt/ftp.thig.com/idepot
echo "//ftp.thig.com/idepot /mnt/ftp.thig.com/idepot cifs defaults,_netdev,rw,credentials=/etc/samba/idepot_credentials,rsize=16384,wsize=16384 0 0" >>  /etc/fstab
