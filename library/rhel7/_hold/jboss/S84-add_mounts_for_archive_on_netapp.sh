#!/bin/bash
mkdir /mnt/archive.logs

echo "//sflgnvlog01.thig.com/archive/prod.jbo${HOSTNAME:9:2} /mnt/archive.logs cifs rw,credfile=/etc/samba/credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
