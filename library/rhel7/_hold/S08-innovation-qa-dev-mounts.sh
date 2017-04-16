#!/bin/bash

mkdir -p /mnt/InnovationFNOL
mkdir -p /mnt/cifs/gnvnetapp02
mkdir -p /mnt/innovation_data


echo "//gnvnetapp02/innovationqa$ /mnt/cifs/gnvnetapp02 cifs defaults,credfile=/etc/samba/credentials 0 0" >> /etc/fstab
. /etc/sdi/thig-settings
echo "gnvnetapp01:/innovation_appdata_${ENVIRONMENT} /mnt/innovation_data nfs rw,vers=3,rsize=65536,wsize=65536,hard,intr,proto=tcp,timeo=600 0 0" >> /etc/fstab
echo "//gnvnetapp01/batch_processing/ImageRight/ModelOffice/InnovationFNOL /mnt/InnovationFNOL cifs defaults,rw,file_mode=0666,dir_mode=0777,credfile=/etc/samba/credentials 0 0" >> /etc/fstab
