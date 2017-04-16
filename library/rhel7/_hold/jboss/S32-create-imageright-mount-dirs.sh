#!/bin/bash

mkdir /mnt/imageright/UWA-Summary -p

#echo '//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/UWA-Summary /mnt/cifs/UWA-Summary cifs defaults,_netdev,noperms,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
 
mkdir -p /mnt/imageright/onlineendorsements
