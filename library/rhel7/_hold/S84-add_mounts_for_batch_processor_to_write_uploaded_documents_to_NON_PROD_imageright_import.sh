#!/bin/bash
. /etc/sdi/thig-settings
mkdir /mnt/imageright/RPMUpload -p
echo "#//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/RPMUpload /mnt/imageright/RPMUpload cifs defaults,rw,noperms,credentials=/etc/samba/credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/RPMUpload /mnt/imageright/RPMUpload cifs defaults,rw,noperms,credentials=/etc/samba/credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab
