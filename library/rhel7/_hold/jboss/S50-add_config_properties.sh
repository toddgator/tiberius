#!/bin/bash
VERSION=1.0.0
echo "Clone the context.xml's from the thig-application-configs-global repo"
## Clone the context.xml's from the thig-application-configs-global repo
. /etc/sdi/thig-settings
. /etc/sdi/sdi.rpm.conf
mkdir /opt/${APP_NAME}/etc
cd /opt/${APP_NAME}/etc
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/${APP_NAME}/config.properties config.properties
chown ${APP_NAME}:${APP_NAME} config.properties
