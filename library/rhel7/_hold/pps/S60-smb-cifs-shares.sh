#!/bin/bash
. /etc/sdi/thig-settings


echo ${ENVIRONMENT} | grep -iq prod && cat << EOF >> /etc/samba/smb.conf
[imports]
        comment = staging directory 
        path = /srv/pro4/data/imports
        valid users = @"THIG-DOMAIN+FA_ProductionPPSImports"
        write list = @"THIG-DOMAIN+FA_ProductionPPSImports"
        create mask = 0644
        directory mask = 02775
        oplocks = No
        level2 oplocks = No

[megprt]
        comment = staging directory
        path = /srv/pro4/data/megprt
        valid users = @"THIG-DOMAIN+pps_prod_megprt_ro"
        write list = @"THIG-DOMAIN+pps_prod_megdata_rw"
        read only = No
        oplocks = No
        level2 oplocks = No

[bank_backup]
        comment = bank backup directory
        path = /srv/pro4/data/bank_backup
        valid users = @"THIG-DOMAIN+pps_prod_bankbackup_ro"

[prtbak]
        path = /srv/pro4/data/prtbak
        valid users  = svc_dailyzip
        read only = No

[eliens]
        comment = eleins directory
        path = /srv/pro4/data/megdata/eliens
        valid users = @"THIG-DOMAIN+pps_prod_megdata_ro"
        write list = "THIG-DOMAIN+svc_elios"

[backup]
        path = /store/pro4
        valid users = @"THIG-DOMAIN+pps_prod_backup_ro"

[pospay]
        comment = pospay share
        path = /srv/pro4/cmschecks/pospay
        valid users = @"THIG-DOMAIN+Domain Users"

[chkoutput]
        comment = chkoutput share
        path = /srv/pro4/cmschecks/chkoutput/archive
        valid users = @"THIG-DOMAIN+Domain Users"

[AP_checks]
        comment = AP (Solomon) check repository
        path = /srv/pro4/AP_checks
        write list = @"THIG-DOMAIN+pps_prod_apchecks_rw"
        browseable = No

[notes_conf]
        comment = Configuration files for notes applications
        path = /etc/notes
        write list = @"THIG-DOMAIN+pps_prod_notes_rw"
        guest ok = Yes

[innovation_checks]
        comment = Commercial Check Files
        path = /srv/pro4/commercial_checks
        valid users = @"THIG-DOMAIN+pps_prod_innovation_ro"
        write list = @"THIG-DOMAIN+pps_prod_innovation_rw"
        browseable = No

[boots]
        comment = boots directory
        path = /srv/pro4/boots/prod/
        valid users = "THIG-DOMAIN+linuxsmb"
        browseable = No

[boots]
        comment = boots directory
        path = /srv/pro4/boots/prod/
        valid users = "THIG-DOMAIN+linuxsmb"
        browseable = No


[innovation]
        comment = innovation check files
        path = /srv/pro4/data/innovation_chks
        valid users = @"THIG-DOMAIN+pps_prod_innovation_ro"
        write list = @"THIG-DOMAIN+pps_prod_innovation_ro"
        create mask = 0664
        directory mask = 02775
        browseable = No

[catletters]
        comment = Catletters access for PlanetPress
        path = /srv/pro4/data/megdata/catletters
        valid users = @"THIG-DOMAIN+pps_prod_users"
        write list = @"THIG-DOMAIN+pps_prod_users"
        create mask = 0664
        directory mask = 02775
        oplocks = No
        level2 oplocks = No

[ftp_check_review]
        comment = Accounting Share requested by Carmen Spence, ticket 235233 on 6/21/2016
        path = /srv/pro4/data/megdata/ftp
        valid users = @"THIG-DOMAIN+pps_prod_ftp_check_review_ro"
        read only = yes
        force user = pro4

[accountingstatus]
        comment = Accounting Share
        path = /srv/pro4/data/megdata/ftp/accountingstatus
        valid users = @"THIG-DOMAIN+pps_prod_accounting_ro"
        write list = @"THIG-DOMAIN+pps_prod_accounting_rw"
        create mask = 0664
        directory mask = 02775

[fslso]
        comment = fslso for accounting
        path = /srv/pro4/data/megdata/ftp/fslso
        valid users = "THIG-DOMAIN+masbell", "THIG-DOMAIN+bdavis", "THIG-DOMAIN+nshrader"
        write list = "THIG-DOMAIN+masbell", "THIG-DOMAIN+bdavis", "THIG-DOMAIN+nshrader"
        create mask = 0664
        directory mask = 02775

[fslsoarchive]
        comment = archive folder for fslso for accounting
        path = /srv/pro4/data/megdata/ftp/fslsoarchive
        valid users = "THIG-DOMAIN+masbell", "THIG-DOMAIN+bdavis", "THIG-DOMAIN+nshrader"
        write list = "THIG-DOMAIN+masbell", "THIG-DOMAIN+bdavis", "THIG-DOMAIN+nshrader"
        create mask = 0664
        directory mask = 02775

[XSL]
        comment = XSL StyleSheets
        read only = No
        browseable = Yes
        path = /srv/pro4/xsl
        valid users = @"THIG-DOMAIN+Domain Users"
        write list = @"THIG-DOMAIN+Domain Users"

[oracle]
        comment = Data for oracle
        force user = pro4
        force group = pro4
        read only = Yes
        follow symlinks = Yes
        wide links = on
        path = /srv/pro4/data/oracle
        valid users = "THIG-DOMAIN+linuxsmb"

[daily]
        comment = Daily export data for oracle
        force user = pro4
        force group = pro4
        read only = yes
        follow symlinks = yes
        wide links = on
        path = /srv/pro4/export/daily
        valid users = "THIG-DOMAIN+linuxsmb"
 
EOF


echo ${ENVIRONMENT} | grep -iq prod || cat << EOF >> /etc/samba/smb.conf
[data]
        comment = ${ENVIRONMENT} MEGDATA
        read only = No
        browseable = Yes
        path = /usr/pro4/data
        valid users = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", "THIG-DOMAIN+mmcbroom", @"THIG-DOMAIN+Linux Admins", @"THIG-DOMAIN+Systems_QA", "THIG-DOMAIN+rroberts"
        write list = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", @"THIG-DOMAIN+Linux Admins", @"THIG-DOMAIN+Systems_QA"

[megprt]
        comment = ${ENVIRONMENT} MEGPRT
        read only = No
        browseable = Yes
        path = /usr/pro4/data/megprt
        valid users = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", @"THIG-DOMAIN+Linux Admins"
        write list = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", @"THIG-DOMAIN+Linux Admins"

[boots]
        comment = ${ENVIRONMENT} BOOTS
        read only = No
        browseable = Yes
        path = /usr/pro4/boots/qa
        valid users = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", @"THIG-DOMAIN+Linux Admins"
        write list = @"THIG-DOMAIN+Team 1","THIG-DOMAIN+lmurphy","THIG-DOMAIN+fpage", @"THIG-DOMAIN+Linux Admins"

[staging]
        comment = boots/staging directory
        path = /srv/pro4/boots/staging/
        valid users = "THIG-DOMAIN+linuxsmb"
        browseable = No

[XSL]
        comment = XSL StyleSheets
        read only = No
        browseable = Yes
        path = /usr/pro4/current/virtual_machine/xsl
        valid users = @"THIG-DOMAIN+Domain Users"
        write list = @"THIG-DOMAIN+Domain Users"


[cmscheck]
        comment = ${ENVIRONMENT} cmschecks
        read only = No
        browseable = Yes
        path = /usr/pro4/cmschecks
        valid users = @"THIG-DOMAIN+Domain Users"
        write list = @"THIG-DOMAIN+Domain Users"

[javalib]
    browseable = yes
    comment = PPS javalib directory
    path = /opt/pro4/current/virtual_machine/javalib
    valid users = @"THIG-DOMAIN+domain users"
    public = yes
    guest ok = yes

EOF
