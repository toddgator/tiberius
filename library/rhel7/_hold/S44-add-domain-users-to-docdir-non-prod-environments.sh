#!/bin/bash
sed -i "s/<\/Location>/       require ldap-group CN=Domain Users,OU=Users,DC=thig,DC=com\n         <\/Location>/g" /etc/httpd/conf.d/vhosts.conf 
