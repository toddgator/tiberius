#!/usr/bin/env bash

. /etc/sdi/thig-settings
. /etc/credentials/jenkins.credfile


##
## Creating and populating the 'sso' directory under the 'virtual_machine'
##
mkdir -p /srv/pro4/sso
chown pro4:'domain users' /srv/pro4/sso
setfacl -dm g:'domain users':rwx /srv/pro4/sso
setfacl -m g:'domain users':rwx /srv/pro4/sso
cd /srv/pro4/sso

PKGLIST="http://inhouse.thig.com/pro4/sso/northgatearinso-sso.jar\
 http://inhouse.thig.com/pro4/sso/pdfextract.jar\
 http://inhouse.thig.com/pro4/sso/proivsso-0.0.1-SNAPSHOT-11.jar"

for pkg in ${PKGLIST}; do
  wget ${pkg}
done

# Download developer controlled sso-related jar files
. /etc/sdi/thig-settings
. /etc/credentials/jenkins.credfile
wget -q --user=${JENKINS_USER} --password=${JENKINS_PASSWORD} -O forgerockapi-3.0-SNAPSHOT.jar "http://jenkins.thig.com/job/forgerockapi-master/lastSuccessfulBuild/artifact/target/forgerockapi-3.0.3-jar-with-dependencies.jar"
wget -q --user=${JENKINS_USER} --password=${JENKINS_PASSWORD} -O addressingSSO-1.0.0.jar "http://jenkins.thig.com/job/addressingsso-master/lastSuccessfulBuild/artifact/target/addressingSSO-1.0.0-SNAPSHOT-jar-with-dependencies.jar"

chown -R pro4:'domain users' /srv/pro4/sso
setfacl -Rm g:'domain users':rwx /srv/pro4/sso
setfacl -Rdm g:'domain users':rwx /srv/pro4/sso

cd /opt/pro4/current/virtual_machine/javalib
if [ ! -d sso ]; then
  ln -s /srv/pro4/sso
else
  mv sso sso.original_from_install
  ln -s /srv/pro4/sso
fi


##
## Creating and populating PPS's 'xsl' directory
##
XSLDIR="/srv/pro4/xsl"
mkdir -p ${XSLDIR}
chown pro4:"domain users" ${XSLDIR}
setfacl -dm g:'domain users':rwx ${XSLDIR}

cd ${XSLDIR}
wget http://sflgnvlms01.thig.com/inhouse/pro4/xsl/xsl.tgz
tar -xvzf xsl.tgz
rm xsl.tgz

# Setting proper default ACL
for fd in $(ls); do
  if [ -d ${fd} ]; then
    setfacl -dm g:'domain users':rwx ${fd}
  fi
done

# Recursively setting ACL & ownership
setfacl -Rm g:'domain users':rwx *
chown -R pro4:'domain users' *

# Removing default '.../xsl' dir and creating symlink to the new one
cd /opt/pro4/current/virtual_machine/
if [ -d xsl ]; then
 mv xsl xsl.installer-default
fi
ln -s ${XSLDIR}
