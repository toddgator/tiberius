#!/bin/bash
echo "
[checkmk-logwatch]
         path = /etc/check_mk
         valid users = @\"THIG-DOMAIN+FAC_$(hostname -s)_RW_CheckMK-Logwatch\", @\"THIG-DOMAIN+Linux Admins\",
	 write list = @\"THIG-DOMAIN+FAC_$(hostname -s)_RW_CheckMK-Logwatch\", @\"THIG-DOMAIN+Linux Admins\",
         read only = no
         public = no
         browseable = yes
         force user = root
" >> /etc/samba/smb.conf

