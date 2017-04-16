#!/bin/bash

. /etc/sdi/thig-settings

# Delete user accounts if they exist
for user in A094505@FL8888 A049705@FL8888 A034688@FL8888 A028835@FL8888 A088644@FL8888 A001082@FL8888 SFL10E35@FL8888 SFLBZ411@FL8888 SFLNGE0B@FL8888; 
do 
 /opt/sdi/sdi_service_scripts/supplemental/delete_openidm_user.sh ${user}
done

# Setup tmp file for pass and reset pwd
cat << \EOF > /tmp/password_base.ldif
dn: thiguuid=sed-me-to-uuid,ou=people,dc=thig,dc=com
changetype: modify
replace: userPassword
userPassword: 2Password
EOF

cat << \EOF > /tmp/passwordresetfalse_base.ldif
dn: thiguuid=sed-me-to-uuid,ou=people,dc=thig,dc=com
changetype: modify
replace: pwdReset
pwdReset: FALSE
EOF

cat << \EOF > /tmp/passwordresettrue_base.ldif
dn: thiguuid=sed-me-to-uuid,ou=people,dc=thig,dc=com
changetype: modify
replace: pwdReset
pwdReset: TRUE
EOF

ROOTPASS="cangetin"
ROOTDN="cn=THIG Admin"

## Create all test user accounts


## A094505@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A094505@FL8888","givenName" : "A094505@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A094505@FL8888", "userPassword":"2Password" ,"cn" : "A094505" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A094505@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A049705@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A049705@FL8888","givenName" : "A049705@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A049705@FL8888", "userPassword":"2Password" ,"cn" : "A049705" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A049705@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A034688@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A034688@FL8888","givenName" : "A034688@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A034688@FL8888", "userPassword":"2Password" ,"cn" : "A034688" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A034688@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A028835@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A028835@FL8888","givenName" : "A028835@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A028835@FL8888", "userPassword":"2Password" ,"cn" : "A028835" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A028835@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A088644@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A088644@FL8888","givenName" : "A088644@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A088644@FL8888", "userPassword":"2Password" ,"cn" : "A088644" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A088644@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A001082@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A001082@FL8888","givenName" : "A001082@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A001082@FL8888", "userPassword":"2Password" ,"cn" : "A001082" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A001082@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## A001082@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "A001082@FL8888","givenName" : "A001082@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"A001082@FL8888", "userPassword":"2Password" ,"cn" : "A001082" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=A001082@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## SFL10E35@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "SFL10E35@FL8888","givenName" : "SFL10E35@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"SFL10E35@FL8888", "userPassword":"2Password" ,"cn" : "SFL10E35" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SFL10E35@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
 ## SFLBZ411@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "SFLBZ411@FL8888","givenName" : "SFLBZ411@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"SFLBZ411@FL8888", "userPassword":"2Password" ,"cn" : "SFLBZ411" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SFLBZ411@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
  ## SFLNGE0B@FL8888
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"ALLSTATE IVANTAGE",  "sn":"AG",  "firstname":"ALLSTATE", "userType" : "A","agencyid" : "8888","userName" : "SFLNGE0B@FL8888","givenName" : "SFLNGE0B@FL8888","thigActiveDirectoryID" : "", "pwdReset" : "FALSE", "mail" : "fake@thig.com",  "fullname":"SFLNGE0B@FL8888", "userPassword":"2Password" ,"cn" : "SFLNGE0B" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SFLNGE0B@FL8888
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@FL8888//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@FL8888//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

 
