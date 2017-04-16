#!/bin/bash
exit
#yum update -y ca-certificates curl nss openssl

#cat << EOF >> /etc/yum.repos.d/cisofy-lynis.repo
#[lynis]
#name=CISOfy Software - Lynis package
#baseurl=https://packages.cisofy.com/community/lynis/rpm/
#enabled=1
#gpgkey=https://packages.cisofy.com/keys/cisofy-software-rpms-public.key
#gpgcheck=1
#EOF

#yum makecache fast
#yum -y --disablerepo "*" --enablerepo "lynis" install lynis

#Secure copy the audit report to a central server: lms01?
