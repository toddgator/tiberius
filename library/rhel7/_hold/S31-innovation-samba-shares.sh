#!/bin/bash

cat <<EOM >> /etc/samba/smb.conf
[innovation-logs]
   comment = Innovation Tomcat Logs
   path = /home/innovation/app/PROD/tomcat/logs
   valid users = @"THIG-DOMAIN+Team Synergy", @"THIG-DOMAIN+Linux Admins", "THIG-DOMAIN+Linuxsmb_dev",
   read only = yes
   public = no
   browseable = yes
   force user = root
   veto files = /Thumbs.db/
   delete veto files = yes

[innovation-user-logs]
   comment = Innovation User Logs
   path = /home/innovation/app/PROD/prefs/log
   valid users = @"THIG-DOMAIN+Team Synergy", @"THIG-DOMAIN+Linux Admins", "THIG-DOMAIN+Linuxsmb_dev",
   read only = yes
   public = no
   browseable = yes
   force user = root
   veto files = /Thumbs.db/
   delete veto files = yes

[Print Directories]
   comment = Repository for batch print output requests
   path = /home/innovation/app/PROD/data/APP-INF
   valid users = @"THIG-DOMAIN+innovation_share_users"
   write list = @printers, @"THIG-DOMAIN+innovation_share_writers"
   guest ok = Yes
   veto files = /Thumbs.db/
   delete veto files = yes

[Batch Requests]
   comment = Repository for batch print output requests
   path = /home/innovation/app/PROD/prefs/print/form/temp
   valid users = @"THIG-DOMAIN+innovation_share_users",
   write list = @printers, @"THIG-DOMAIN+innovation_share_writers"
   guest ok = Yes
   veto files = /Thumbs.db/
   delete veto files = yes

[innovation]
   comment = Innovation app logs directory
   path = /home/innovation/app/PROD/prefs/log
   browseable = yes
   valid users = @"THIG-DOMAIN+innovation_share_users", @"THIG-DOMAIN+Linux Admins",
   guest ok = Yes
   veto files = /Thumbs.db/
   delete veto files = yes

[Innovation_home_directory]
   comment = Innovation home directory
   path = /home/innovation/
   valid users = @"THIG-DOMAIN+Linux Admins", "THIG-DOMAIN+mmcbroom", "THIG-DOMAIN+jcroley"
   write list = @"THIG-DOMAIN+Linux Admins", "THIG-DOMAIN+mmcbroom", "THIG-DOMAIN+jcroley"
   public = No
   guest ok = No
   force user = root
   veto files = /Thumbs.db/
   delete veto files = yes

[innovation-home-directory]
   comment = Innovation Home Directory
   path = /home/innovation/
   valid users = @'THIG-DOMAIN+Linux Admins', 'THIG-DOMAIN+mmcbroom'
   write list = @'THIG-DOMAIN+Linux Admins', 'THIG-DOMAIN+mmcbroom'
   public = no
   browseable = yes
   force user = root
   veto files = /Thumbs.db/
   delete veto files = yes

EOM
