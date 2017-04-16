#!/bin/bash

. /etc/sdi/thig-settings

# Delete user accounts if they exist
for user in AUTOMATION_AG@THIG AUTOMATION_ES@THIG AUTOMATION_UW@THIG SVC_AUTOTEST1@THIG SVC_AUTOTEST2@THIG SVC_AUTOTEST3@THIG SVC_AUTOTEST4@THIG SVC_AUTOTEST5@THIG SVC_AUTOTEST6@THIG SVC_AUTOTEST7@THIG SVC_AUTOTEST8@THIG SVC_AUTOTEST9@THIG SVC_AUTOTEST10@THIG COMMERCIAL@AL7777 COMMERCIAL@SC7777 SNAIR@THIG SROBINSON@THIG SWELLS@THIG; 
do 
 /opt/sdi/sdi_service_scripts/supplemental/delete_openidm_user.sh ${user}
done

# Setup tmp file for pass and reset pwd
cat << \EOF > /tmp/password_base.ldif
dn: thiguuid=sed-me-to-uuid,ou=people,dc=thig,dc=com
changetype: modify
replace: userPassword
userPassword: 1Password
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

## AUTOMATION_AG@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"AG",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "AUTOMATION_AG@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "automation_ag", "pwdReset" : "FALSE", "mail" : "AUTOMATION_AG@THIG.COM",  "fullname":"AUTOMATION_AG", "userPassword":"1Password" ,"cn" : "AUTOMATION AG" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=AUTOMATION_AG@THIG
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin
 
curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .
 
# Add the thigPermission needed for this one account...
curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigPermission/-", "value":"AgencyOverride"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 echo /tmp/password_$(echo $USER|sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER|sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## AUTOMATION_ES@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"ES",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "AUTOMATION_ES@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "automation_es", "pwdReset" : "FALSE", "mail" : "AUTOMATION_ES@THIG.COM",  "fullname":"AUTOMATION_ES", "userPassword":"1Password" ,"cn" : "AUTOMATION ES" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=AUTOMATION_ES@THIG
 ROLE=RPM_UnderwriterPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin
 
curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .
 
 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 echo "/opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif"
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## AUTOMATION_UW@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"UW",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "AUTOMATION_UW@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "automation_uw", "pwdReset" : "FALSE", "mail" : "AUTOMATION_UW@THIG.COM",  "fullname":"AUTOMATION_UW", "userPassword":"1Password" ,"cn" : "AUTOMATION UW" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=AUTOMATION_UW@THIG
 ROLE=RPM_UnderwriterBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"



## SVC_AUTOTEST1@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC1",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST1@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest1", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST1@THIG.COM",  "fullname":"SVC_AUTOTEST1", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST1" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST1@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST2@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC2",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST2@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest2", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST2@THIG.COM",  "fullname":"SVC_AUTOTEST2", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST2" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST2@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST3@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC3",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST3@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest3", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST3@THIG.COM",  "fullname":"SVC_AUTOTEST3", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST3" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST3@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST4@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC4",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST4@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest4", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST4@THIG.COM",  "fullname":"SVC_AUTOTEST4", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST4" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")


 USER=SVC_AUTOTEST4@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST5@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC5",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST5@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest5", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST5@THIG.COM",  "fullname":"SVC_AUTOTEST5", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST5" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST5@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

## SVC_AUTOTEST6@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC6",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST6@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest6", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST6@THIG.COM",  "fullname":"SVC_AUTOTEST6", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST6" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")


 USER=SVC_AUTOTEST6@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST7@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC7",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST7@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest7", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST7@THIG.COM",  "fullname":"SVC_AUTOTEST7", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST7" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST7@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

## SVC_AUTOTEST8@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC8",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST8@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest8", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST8@THIG.COM",  "fullname":"SVC_AUTOTEST8", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST8" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST8@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST9@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC9",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST9@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest9", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST9@THIG.COM",  "fullname":"SVC_AUTOTEST9", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST9" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SVC_AUTOTEST9@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SVC_AUTOTEST10@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"AUTOMATION",  "sn":"SVC10",  "firstname":"AUTOMATION", "userType" : "I","agencyid" : "7777","userName" : "SVC_AUTOTEST10@THIG","givenName" : "AUTOMATION","thigActiveDirectoryID" : "svc_autotest10", "pwdReset" : "FALSE", "mail" : "SVC_AUTOTEST10@THIG.COM",  "fullname":"SVC_AUTOTEST10", "userPassword":"1Password" ,"cn" : "SVC_AUTOTEST10" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

USER=SVC_AUTOTEST10@THIG
 ROLE=RPM_FullPlus
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresetfalse_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## COMMERCIAL@AL7777
#idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"COMMERCIAL",  "sn":"AL",  "firstname":"COMMERCIAL", "userType" : "I","agencyid" : "7777","userName" : "COMMERCIAL@AL7777","givenName" : "AUTOMATION","thigActiveDirectoryID" : "COMMERCIAL@AL7777", "pwdReset" : "FALSE", "mail" : "COMMERCIAL_AL7777@THIG.COM",  "fullname":"Commercial Alabama", "userPassword":"1Password" ,"cn" : "Commercial Alabama" }' "http://localhost:8080/openidm/managed/user?_action=create")

#idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

# USER=COMMERCIAL@AL7777
# ROLE=RPM_AgencyBase
# OPERATION=add
# # Valid OPERATION's are add and remove
# ADMIN_USER=openidm-admin
# ADMIN_PASS=openidm-admin

#curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 # Verify it works by pull the Role
# curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## COMMERCIAL@SC7777
#idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"COMMERCIAL",  "sn":"SC",  "firstname":"COMMERCIAL", "userType" : "I","agencyid" : "7777","userName" : "COMMERCIAL@SC7777","givenName" : "AUTOMATION","thigActiveDirectoryID" : "COMMERCIAL@SC7777", "pwdReset" : "FALSE", "mail" : "COMMERCIAL_SC7777@THIG.COM",  "fullname":"Commercial South Carolina", "userPassword":"1Password" ,"cn" : "Commercial South Carolina" }' "http://localhost:8080/openidm/managed/user?_action=create")

#idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")



# USER=COMMERCIAL@SC7777
# ROLE=RPM_AgencyBase
# OPERATION=add
# # Valid OPERATION's are add and remove
# ADMIN_USER=openidm-admin
# ADMIN_PASS=openidm-admin

#curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 # Verify it works by pull the Role
# curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"


## SNAIR@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"SWAPNA",  "sn":"NAIR",  "firstname":"Swapna", "userType" : "I","agencyid" : "7777","userName" : "SNAIR@THIG","givenName" : "SNAIR@THIG","thigActiveDirectoryID" : "snair","mail" : "SWAPNA.NAIR@ISCS.COM",  "fullname":"Swapna Nair", "userPassword":"1Password" ,"cn" : "Swapna Nair" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")

 USER=SNAIR@THIG
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif

 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresettrue_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif

 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

## SROBINSON@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"SCOTT",  "sn":"ROBINSON",  "firstname":"Scott", "userType" : "I","agencyid" : "7777","userName" : "SROBINSON@THIG","givenName" : "SROBINSON@THIG","thigActiveDirectoryID" : "srobinson","mail" : "SCOTT.ROBINSON@ISCS.COM",  "fullname":"Scott Robinson", "userPassword":"1Password" ,"cn" : "Scott Robinson" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")
 USER=SROBINSON@THIG
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif

 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresettrue_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 
 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

## SWELLS@THIG
idm_id_to_create=$(curl --header 'Content-Type: application/json' --header "X-OpenIDM-Username: openidm-admin" --header "X-OpenIDM-Password: openidm-admin" --request POST --data '{  "name":"STEPHEN",  "sn":"WELLS",  "firstname":"Stephen", "userType" : "I","agencyid" : "7777","userName" : "SWELLS@THIG","givenName" : "SWELLS@THIG","thigActiveDirectoryID" : "swells","mail" : "STEPHEN.WELLS@ISCS.COM",  "fullname":"Stephen Wells", "userPassword":"1Password" ,"cn" : "Stephen Wells" }' "http://localhost:8080/openidm/managed/user?_action=create")

idm_id=$(echo $idm_id_to_create | jq . | grep "_id" | awk '{print $2}' | sed 's/"//g' | sed "s/,//g")


 USER=SWELLS@THIG
 ROLE=RPM_AgencyBase
 OPERATION=add
 # Valid OPERATION's are add and remove
 ADMIN_USER=openidm-admin
 ADMIN_PASS=openidm-admin

curl -ks --request POST --header 'Content-Type: application/json' --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --data '[{"operation":"'"${OPERATION}"'", "field":"thigRole/-", "value":"'"${ROLE}"'"}]' "http://localhost:8080.thig.com/openidm/managed/user/${idm_id}?_action=patch" | jq .

 sed "s/sed-me-to-uuid/$USER/g" /tmp/password_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g").ldif

 sed "s/sed-me-to-uuid/$USER/g" /tmp/passwordresettrue_base.ldif > /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 /opt/forgerock/opendj/bin/ldapmodify -h localhost -p 1389 -D "$ROOTDN" -w $ROOTPASS -f /tmp/password_$(echo $USER | sed "s/@THIG//g")-reset.ldif
 
 # Verify it works by pull the Role
 curl -ks --header "X-OpenIDM-Username: ${ADMIN_USER}" --header "X-OpenIDM-Password: ${ADMIN_PASS}" --request GET "http://localhost:8080/openidm/managed/user?_queryFilter=userName+eq+\"${USER}\"&_prettyPrint=true"

