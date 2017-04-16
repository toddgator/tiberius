#!/bin/bash
mkdir /mnt/imageright/onlineendorsements -p
mkdir /mnt/imageright/UWA-Summary -p
mkdir /mnt/imageright/UNDRQuickQuote -p

echo '//batchprocessor.thig.com/batch_processing/ImageRight/Production/UWA-Summary /mnt/cifs/UWA-Summary cifs defaults,_netdev,noperm,rw,credentials=/etc/samba/batchprocessing_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab

echo '//thigir01/imagesj/images/oasis/OnlineEndorsements /mnt/imageright/onlineendorsements cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//thigir01/ColdImport/UNDRQuickQuote /mnt/imageright/UNDRQuickQuote cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
