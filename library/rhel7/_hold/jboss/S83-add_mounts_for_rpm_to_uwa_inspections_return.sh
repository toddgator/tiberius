#!/bin/bash
mkdir -p /mnt/cifs/UWAInspectionReturn
echo "//batchprocessor.thig.com/batch_processing/prod/UWAInspectionReturn /mnt/cifs/UWAInspectionReturn cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0" >> /etc/fstab

