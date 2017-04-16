#!/bin/bash

. /etc/sdi/thig-settings

echo "$(hostname -s)" | grep "2" && exit

cat << EOF > /tmp/fix_openidm_user.sql
Delete FROM OPEN_IDM.internaluser;
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('openidm-admin', '0', 'openidm-admin', 'openidm-admin,openidm-authorized');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('anonymous', '0', 'anonymous', 'openidm-reg');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('svc_rpm_admin', '0', '7v9VKrfDAhhyQ7Pm', 'openidm-admin,openidm-authorized');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('svc_sahara_admin', '0', 'rNTqDwWP6Hbp4HtE', 'openidm-admin,openidm-authorized');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('svc_rolesmaster_admin', '0', '26r2bJTgPKw6HxNd', 'openidm-admin,openidm-authorized');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('svc_pps_admin', '0', 'fh8FRrStqrjVGga3', 'openidm-admin,openidm-authorized');
INSERT INTO internaluser (objectid, rev, pwd, roles) VALUES ('svc_idm_load_balancer', '0', 'svc_idm_load_balancer', 'openidm-admin,openidm-authorized');
COMMIT;
EXIT;
EOF

export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/lib

sqlplus64 -S "OPEN_IDM/0p3N1DM\$@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com)(Port=1521))(CONNECT_DATA=(SID=${DBNAME})))" @/tmp/fix_openidm_user.sql

