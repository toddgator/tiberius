#!/bin/bash
# 201402071200
##
# pps_real_time_updates configuration
##

export APP_NAME=$(basename $0 | sed "s/\.sh$//g" | sed "s/^S..-//g")
##
# Memory Settings
##

##
# SDI application configuration
##
echo "$(grep JVM /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf)

PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $3 } ')
DEBUGPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $5 } ')
JMXPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $4 } ')

# URL where the current production build lives
$(grep URL /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf)

BASEDIR=/opt
APP_NAME=${APP_NAME}
" > /etc/sdi/sdi.${APP_NAME}.conf

. /etc/sdi/sdi.${APP_NAME}.conf

ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/sdi.${APP_NAME}

. /etc/credentials/jenkins.credfile

ARCHIVE=real-time-updates-1.0.0.jar

## Create directories for logs.thig.com to samba into
## Tested working on 11.26.13 CMH

      useradd -d "/opt/${APP_NAME}" "${APP_NAME}"
      mkdir -p "/opt/${APP_NAME}/logs" "/opt/${APP_NAME}/bin"
      cd "/opt/${APP_NAME}/bin"
      wget -q --user=${JENKINS_USER} --password=${JENKINS_PASSWORD} -O "${ARCHIVE}" "${APP_URL}"

mkdir /var/log/${APP_NAME}
grep "/var/log/${APP_NAME}" /etc/fstab || echo "/opt/${APP_NAME}/logs              /var/log/${APP_NAME}          bind    defaults,bind   0 0" >> /etc/fstab
chown -R ${APP_NAME}:${APP_NAME} /opt/${APP_NAME}/
chmod 755 /opt/${APP_NAME} 

chkconfig sdi.real-time-updates on
