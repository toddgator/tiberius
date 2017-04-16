#!/bin/bash
mkdir -p /mnt/pps.orange.thig.com/boots
mkdir -p /mnt/pps.thig.com/boots

echo 'pps.orange.thig.com:/srv/pro4/boots/orange /mnt/pps.orange.thig.com/boots nfs ro,rsize=65536,wsize=65536,hard,intr,proto=tcp,timeo=600 0 0' >> /etc/fstab
echo 'pps.thig.com:/srv/pro4/boots/prod /mnt/pps.thig.com/boots nfs ro,vers=4,rsize=65536,wsize=65536,hard,intr,proto=tcp,timeo=600 0 0' >> /etc/fstab
