#!/bin/bash
# 
# Imageright Mounts on Linux hosts for watched folder pickup
# Online Endorsements, dropped by RPM via imageright.cold.directory property in rpm-env.properties.
# QA: 
# PROD: 
# UWA, 
#
# Filetype: Applications
# Role(s): DOC
# Local Mountpoint: /mnt/cifs/docdir/imageright
# QA Remote watched directory location: 
# Prod Remote watched directory location: 
# Process using mount: docdir
#
# Filetype: Inspections
# Role(s): BAT
# Local Mountpoint: /mnt/thigir01/imagesj/images/oasis/InspectionDepotDocArch
# QA Remote watched directory location: Not implemented in QA
# Prod Remote watched directory location: 
# Process using mount: docdir
#
# Filetype: Inspections
# Role(s): BAT
# Local Mountpoint: /mnt/thigir01/imagesj/images/oasis/InspectionDepotDocArch
# QA Remote watched directory location: Not implemented in QA
# Prod Remote watched directory location:
# Process using mount: docdir
#
#
# Disabled IR Import folders
# mkdir -p /mnt/imageright/AAI
# mkdir -p /mnt/imageright/CATTLetters
# mkdir -p /mnt/imageright/InspectionDepot
# mkdir -p /mnt/imageright/AFUP
# echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/AAI                          /mnt/imageright/AAI cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
# echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/CATTLetters                  /mnt/imageright/CATTLetters cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
# echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/InspectionDepot              /mnt/imageright/InspectionDepot cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
# echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/AFUP                         /mnt/imageright/AFUP cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab


mkdir -p /mnt/imageright/onlineendorsements

mkdir -p /mnt/imageright/uwa
mkdir -p /mnt/imageright/AFUP
mkdir -p /mnt/imageright/Applications
mkdir -p /mnt/imageright/ClaimAcknowledgementLetter
mkdir -p /mnt/imageright/FNOL
mkdir -p /mnt/imageright/Millennium
mkdir -p /mnt/imageright/RenewalReview
mkdir -p /mnt/imageright/RPMUpload
mkdir -p /mnt/imageright/UNDRQuickQuote

echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/UWA                          /mnt/imageright/uwa cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/OnlineEndorsements           /mnt/imageright/onlineendorsements cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/AFUP                         /mnt/imageright/AFUP cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/Applications                 /mnt/imageright/Applications cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/ClaimAcknowledgementLetter   /mnt/imageright/ClaimAcknowledgementLetter cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/FNOL                         /mnt/imageright/FNOL cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/Millennium                   /mnt/imageright/Millennium cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/RenewalReview                /mnt/imageright/RenewalReview cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/RPMUpload                    /mnt/imageright/RPMUpload cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab
echo '//batchprocessor.thig.com/batch_processing/ImageRight/ModelOffice/UNDRQuickQuote               /mnt/imageright/UNDRQuickQuote cifs defaults,_netdev,rw,noperm,credentials=/etc/samba/rpm_to_ir_cold_credentials,rsize=16384,wsize=16384 0 0' >> /etc/fstab

