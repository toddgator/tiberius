#!/bin/bash
VERSION=1.0
. /etc/sdi/thig-settings

shopt -s nullglob

BASEDIR="/opt/sdi/thig-server-role-build-scripts"

for script in ${BASEDIR}/roles/odj/all/*.sh ${BASEDIR}/roles/odj/${ENVIRONMENT}/*.sh
do
   echo "Attempting to run $script"
   /bin/bash $script
done
