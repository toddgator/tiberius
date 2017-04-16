#!/bin/bash
for application in `find /opt -maxdepth 1 -type l -print | grep -v java | sed "s|/opt/||g"`
 do

cat << EOF >> /etc/samba/smb.conf
[${application}]
         path = /opt/${application}/conf
         valid users = @"THIG-DOMAIN+Team Synergy", @"THIG-DOMAIN+Linux Admins",
         read only = yes
         force user = root
         public = no
         browseable = yes
EOF

 done
