#!/bin/bash
#
#	Creates mount points and then adds the relevant configuration lines to 
# /etc/fstab so the mounts will	persist over reboots.

. /etc/sdi/thig-settings

if [[ $ENVIRONMENT == "dmz" ]]; then exit; fi

mkdir /mnt/cifs/stats -p
mkdir /mnt/cifs/reports -p
mkdir /mnt/cifs/temp -p
mkdir /mnt/cifs/logs -p

ln -s /opt/sdi/thig-application-configs-global/credentials/batchprocessing_credentials /etc/samba/batchprocessing_credentials
ln -s /opt/sdi/thig-application-configs-global/credentials/applogs_${ENVIRONMENT}_credentials /etc/samba/applogs_${ENVIRONMENT}_credentials

echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/stats /mnt/cifs/stats cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0"  >> /etc/fstab
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/reports /mnt/cifs/reports cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0"  >> /etc/fstab
echo "//batchprocessor.thig.com/batch_processing/${ENVIRONMENT}/temp /mnt/cifs/temp cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0"  >> /etc/fstab
echo "//batchprocessor.thig.com/app_logs/${ENVIRONMENT} /mnt/cifs/logs cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/applogs_${ENVIRONMENT}_credentials,rsize=16384,wsize=16384 0 0"  >> /etc/fstab

 
