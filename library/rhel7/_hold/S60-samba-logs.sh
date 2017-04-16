#!/bin/bash

cat << EOF >> /etc/samba/smb.conf

[forgerock]
         path = /opt/forgerock
         valid users = @"THIG-DOMAIN+Linux Admins", "THIG-DOMAIN+linuxsmb_dev", @"THIG-DOMAIN+D_Systems"
         read only = yes
         force user = root
         public = no
         browseable = yes
EOF

