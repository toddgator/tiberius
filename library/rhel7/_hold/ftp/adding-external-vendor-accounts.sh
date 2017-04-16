#!/usr/bin/env bash


# admin accounts
groupadd -g 502 ftpsecure
useradd -u 502 -g 502 ftpsecure

# banking
groupadd -g 500 eftlockbox
useradd -u 500 -g 500 eftlockbox
groupadd -g 527 eft_admin
useradd -u 527 -g 527 eft_admin
groupadd -g 504 svc_eft.thig.com
useradd -u 504 -g 504 svc_eft.thig.com
groupadd -g 524 sungard
useradd -u 524 -g 524 sungard
groupadd -g 547 wellsfargo
useradd -u 547 -g 547 wellsfargo


# inspections
groupadd -g 501 millennium
useradd -u 501 -g 501 millennium
groupadd -g 534 idepot
useradd -u 534 -g 534 idepot

###
###
###  BEGIN Independent Adjuster block
###
###
# Create iafeed user to be used to connect from sflgnvbat01 running pentaho to pull in the TH_RETURN files
useradd iafeed

# claims IA users
# passwords are in password.thig.com
mkdir -vp /var/ftp/IA
chown root:root /var/ftp/IA
chmod 755 /var/ftp/IA/* -R

for adjuster in allcat amcat pacesetter worley;
do 
  useradd -g sftponly -d /var/ftp/IA/$adjuster -s /sbin/nologin $adjuster
  mkdir /var/ftp/IA/$adjuster/return_files
  mkdir /home/iafeed/$adjuster
  chown -R $adjuster:adjuster /home/iafeed/$adjuster
  echo "/home/iafeed/${adjuster}/ /var/ftp/IA/${adjuster}/return_files        none    bind" >> /etc/fstab
done

# for ChRoot over sftp, home dirs must be owned by root: https://bensmann.no/restrict-sftp-users-to-home-folder/
chown root:root /var/ftp/IA/*

###
###
###  END Independent Adjuster block
###
###


# iscs (innovation)
groupadd -g 516 iscs
useradd -u 516 -g 516 iscs
groupadd -g 538 innov_admin
useradd -u 538 -g 538 innov_admin

# drc (ratemaker)
groupadd -g 517 DRC
useradd -u 517 -g 517 DRC

# dba
groupadd -g 519 dba
useradd -u 519 -g 519 dba

# ftpbackup
groupadd -g 520 ftpbackup
useradd -u 520 -g 520 ftpbackup

# thig
groupadd -g 526 thig
useradd -u 526 -g 526 thig

# Netapp
groupadd -g 532 netapp
useradd -u 532 -g 532 netapp

# usps
groupadd -g 533 usps
useradd -u 533 -g 533 usps

# ppsadmin
groupadd -g 535 ppsadmin
useradd -u 535 -g 535 ppsadmin

# pentaho
groupadd -g 545 pentaho
useradd -u 545 -g 545 pentaho

# svc_latitude
groupadd -g 549 svc_latitude
useradd -u 549 -g 549 svc_latitude
# oir
groupadd -g 550 oir
useradd -u 550 -g 550 oir

# citizens
groupadd -g 551 citizens_submissions
useradd -u 551 -g 551 citizens_submissions

# ivantage/allstate
groupadd -g 557 ivantage
useradd -u 557 -g 557 ivantage


# /sbin/nologin user list
NOLOGIN_ACCOUNTS="ftpsecure svc_eft.thig.com iscs"

# updating the default shell for these accounts to '/sbin/nologin'
for account in ${NOLOGIN_ACCOUNTS}; do
  usermod -s /sbin/nologin "${account}"
done

# Creating a pre-existing directory from previous ftp.thig.com server
mkdir /home/InspectionsArchive
chown millennium:millennium /home/InspectionsArchive

# Updating some permissions for certain /home directories
chmod 2770 /home/eftlockbox
setfacl -m g:"ftpbackup":rwx /home/eftlockbox
chmod 775 /home/idepot
chmod 755 /home/InspectionsArchive
chmod 750 /home/millennium
setfacl -m g:"ftpbackup":rx /home/millennium
