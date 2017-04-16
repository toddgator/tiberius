#!/bin/bash
. /etc/sdi/thig-settings
# Sanity check -- this should never ever ever run in production
hostname -s | grep -i "sflgnvodj" && exit
hostname -s | grep -i "bflgnvodj" && exit

echo ${ENVIRONMENT} | grep -i "prod" && exit
echo ${ENVIRONMENT} | grep -i "beta" && exit


cat << EOF > /tmp/clean_openidm_user_passwords.sql
update MANAGEDOBJECTS
set FULLOBJECT =regexp_replace(FULLOBJECT, '"password":\{".crypto.*?openidm-sym-default"\}\}\},', '"password":"1Password",')
   where OBJECTTYPES_ID = (select id from OBJECTTYPES where objecttype =  'managed/user') ;
COMMIT;
update MANAGEDOBJECTS
set FULLOBJECT =regexp_replace(FULLOBJECT, '"ldapPassword":\{".crypto.*?openidm-sym-default"\}\}\},', '"ldapPassword":"1Password",')
   where OBJECTTYPES_ID = (select id from OBJECTTYPES where objecttype =  'managed/user') ;
COMMIT;
EXIT;
EOF
. /etc/sdi/thig-settings

export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
sqlplus64 -S "OPEN_IDM/0p3N1DM\$@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com)(Port=1521))(CONNECT_DATA=(SID=${DBNAME})))" @/tmp/clean_openidm_user_passwords.sql

