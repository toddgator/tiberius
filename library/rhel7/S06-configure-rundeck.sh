#!/bin/bash

. /etc/sdi/thig-settings

#Disable default admin account and create thig_rundeck user
sed -i 's/admin:admin/#admin:admin/g' /etc/rundeck/realm.properties
echo 'thig_rundeck: MD5:824647f751204aaffce1ed0bf0ef854a,user,admin,architect,deploy,build' >> /etc/rundeck/realm.properties

#Import SSH key pairs
cp /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/certs/id_rsa* /var/lib/rundeck/.ssh/

#Import Resource Node XMLs
mkdir /var/lib/rundeck/thig-resources
cp /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/*.xml /var/lib/rundeck/thig-resources/

#Create "Projects" to match THIG Environments (Provisioning)
#IN PROGRESS
