#!/bin/bash
. /etc/sdi/thig-settings
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=CHINES@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=LMURPHY@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=TSMITH@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=JPARRISH@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=RGILLINS@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=FPAGE@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=JLLEWELLYN@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=JOWEN@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=LANDERSON@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=KROSENLUND@THIG"
curl -k --request POST --header 'Content-Type: application/json' --header 'X-OpenIDM-Username: openidm-admin' --header 'X-OpenIDM-Password: openidm-admin' --data '[{"operation":"replace","field":"thigPermission","value":["RoleMasterAccess"]}]' "http://localhost:8080/openidm/managed/user?_action=patch&_queryId=for-userName&uid=MCHRISTIE@THIG"