#!/bin/bash

. /etc/sdi/thig-settings

## Create symlinks for web_services configuration files
cd /usr/pro4/current/web_services/application/WEB-INF/
rm -f webservices.xml web.xml connectors.xml
for fd in webservices.xml web.xml connectors.xml; do
  ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/web_services/${fd}
done

## Create symlinks for gateway configuration files
cd /usr/pro4/current/gateway/application/WEB-INF/
mv web.xml /tmp/web.xml.gateway-default
mv config.xml /tmp/config.xml.gateway-default
rm -f web.xml config.xml
for fd in web.xml config.xml; do
  cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/gateway/${fd} .
done

## Copy in the default set of run.meg* and gateway startup scripts
cp /opt/sdi/pps_scripts/scripts/* /srv/pro4/scripts/

## Search and replace environment specific variables within these scripts
SCRIPTSHOME="/srv/pro4/scripts"
USERRUNSCRIPTS="${SCRIPTSHOME}/run.meg ${SCRIPTSHOME}/run.megdev ${SCRIPTSHOME}/run.meg-always ${SCRIPTSHOME}/run.meg.nolock"
GATEWAYRUNSCRIPTS="${SCRIPTSHOME}/runppsgateway ${SCRIPTSHOME}/runppsdevgateway"

for fd in ${USERRUNSCRIPTS} ${GATEWAYRUNSCRIPTS}; do
  if [ -f ${fd} ]; then
    echo "Updating configuration for file ${fd}..."
    sed -i "s/sed-me-to-dbname/${DBNAME}/g" ${fd}
    echo "Done."
  fi
done
