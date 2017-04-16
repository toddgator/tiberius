#!/usr/bin/env bash

# Adding shares for automated processes
cat << EOF >> /etc/samba/smb.conf

[eftlockbox]
    comment = Wachovia Lockbox Share
    path = /home/eftlockbox
    browseable = yes
    guest ok = no
    writable = no
    valid users = @eftlockbox
    write list = @eftlockbox

[wellsfargo]
    comment = Wellsfargo Lockbox reporting Share
    path = /home/wellsfargo
    browseable = yes
    guest ok = no
    writable = no
    valid users = @eftlockbox
    write list = @eftlockbox

[millennium]
    comment = Millennium Inspections Share
    path = /home/millennium
    browseable = yes
    guest ok = no
    valid users = @millennium
    write list = @millennium

[InspectionsArchive]
    comment = Inspections Archive Share, pulled via InspectionsArchive process on sflgnvbat01
    path = /home/InspectionsArchive
    browseable = yes
    guest ok = no
    valid users = @millennium
    write list = @millennium

[idepot]
    comment = Idepot
    path = /home/idepot
    force user = idepot
    force group = idepot
    browseable = yes
    guest ok = yes
    valid users = @idepot, todd
    write list = @idepot

EOF

for 
# Adding applicable permissions since some of these shares are under the /home
# directory and by nature don't have permissions open enough to be shared by
# Samba natively.
for directory in /home/eftlockbox /home/wellsfargo /home/millennium /home/InspectionsArchive /home/idepot; do
  chmod -v 750 ${directory}
done

# Make sure the sernet-samba-smbd service is enabled at boot.
systemctl enable sernet-samba.smbd.service
