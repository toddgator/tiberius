#!/bin/bash
echo "
[idepot]
         path = /home/idepot/
         valid users = idepot
         write list = idepot
         force user = idepot
         read only = no
         public = no
         browseable = yes
" >> /etc/samba/smb.conf

