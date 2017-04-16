#!/bin/bash
# 201406061622

### Environment setup
## Create specific sdi.${APP_NAME}.conf file with info in sdi_service_scripts/supplemental/ports.txt
## symlinked filename must conform to filename Sxx-name_of_app.sh for this template to work w/o modification
export APP_NAME=$(basename $0 | sed "s/\.sh$//g" | sed "s/^S..-//g")
. /etc/sdi/thig-settings

## Symlink the service script from the github repo to /etc/init.d
## Tested working on 11.26.13 CMH
ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/sdi.${APP_NAME}

## Create the application conf file that exists in /etc/sdi
echo "PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $3 } ')
DEBUGPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt| grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $5 } ')
JMXPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $4 } ')
SHUTDOWNPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $6 } ')
JVMHEAPMIN=$(cat /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf | grep JVMHEAPMIN | awk -F= ' { print $2 } ')
JVMHEAPMAX=$(cat /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf | grep JVMHEAPMAX | awk -F= ' { print $2 } ')
JVMPERMGEN=$(cat /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf | grep JVMPERMGEN | awk -F= ' { print $2 } ')
BASEDIR=/opt
APP_NAME=${APP_NAME}
$(grep URL /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf)
" > /etc/sdi/sdi.${APP_NAME}.conf

### Prerequisites
## Install latest JDK7
## Tested working on 11.26.13 CMH
if [[ ! -d /opt/java ]]
 then
  /opt/sdi/thig-server-role-build-scripts/applications/java/rhel65.java.latest.install.sh
 fi
## Install latest Apache Tomcat
## Tested working on 11.26.13 CMH
. /etc/sdi/sdi.${APP_NAME}.conf
/opt/sdi/thig-server-role-build-scripts/applications/tomcat/rhel65.tomcat.latest.install.sh

## Add ${APP_NAME} user
useradd -d ${BASEDIR}/${APP_NAME} ${APP_NAME}

## Install ${APP_NAME} WAR from Jenkins
. /etc/credentials/jenkins.credfile
wget -q --user=${JENKINS_USER} --password=${JENKINS_PASSWORD} -O /tmp/ROOT.war "${APP_URL}"
md5sum /tmp/ROOT.war
rm -f ${BASEDIR}/${APP_NAME}/webapps/ROOT.war
cp /tmp/ROOT.war ${BASEDIR}/${APP_NAME}/webapps

## Update startup.sh and server.xml to include debugging JPDA configs, jmx and listening ports
sed -i "s/exec \"\$PRGDIR\"\/\"\$EXECUTABLE\" start \"\$@\"//g" ${BASEDIR}/${APP_NAME}/bin/startup.sh
. /etc/sdi/sdi.${APP_NAME}.conf
cat << EOF >> ${BASEDIR}/${APP_NAME}/bin/startup.sh
export JAVA_HOME=/opt/java
export JPDA_ADDRESS=${DEBUGPORT}
export JPDA_TRANSPORT=dt_socket
export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=${JMXPORT} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Xms${JVMHEAPMIN} -Xmx${JVMHEAPMAX} -XX:PermSize=${JVMPERMGEN} -XX:MaxPermSize=${JVMPERMGEN} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2 -Dgrails.env=${ENVIRONMENT}"
EOF
# NOTE: REMOVE THE PERMGEN WHEN GOING TO JAVA 8
cat << \EOF >> ${BASEDIR}/${APP_NAME}/bin/startup.sh
exec "$PRGDIR"/"$EXECUTABLE" jpda start "$@"
EOF
sed -i "s/8080/${PORT}/g" ${BASEDIR}/${APP_NAME}/conf/server.xml

## Copy in jars needed for tomcat applications
cd ${BASEDIR}/${APP_NAME}/lib
wget -r --no-parent --reject "index.html*" -q -nH -nd http://sflgnvlms01.thig.com/inhouse/${APP_NAME}/

## Disable AJP
sed -i "s/ 8009 -->/ 8009/g" ${BASEDIR}/${APP_NAME}/conf/server.xml
sed -i "s/AJP\/1.3\" redirectPort=\"8443\" \/>/AJP\/1.3\" redirectPort=\"8443\" \/>\r\n\r\n    -->/g" ${BASEDIR}/${APP_NAME}/conf/server.xml

## Change shutdown port (so multiple apps can live on one host)
sed -i "s/Server port=\"8005\"/Server port=\"${SHUTDOWNPORT}\"/g" ${BASEDIR}/${APP_NAME}/conf/server.xml

## Create directories for logs.thig.com to samba into
## Tested working on 11.26.13 CMH
mkdir ${BASEDIR}/${APP_NAME}/logs
chown -R ${APP_NAME}:${APP_NAME} ${BASEDIR}/${APP_NAME}/logs
mkdir /var/log/${APP_NAME}
grep "/var/log/${APP_NAME}" /etc/fstab || echo "${BASEDIR}/${APP_NAME}/logs              /var/log/${APP_NAME}          bind    defaults,bind   0 0" >> /etc/fstab
chown -R ${APP_NAME}:${APP_NAME} ${BASEDIR}/${APP_NAME}/

unalias cp &> /dev/null

. /etc/sdi/thig-settings
  cp /opt/sdi/thig-application-configs-global/roles/${ROLE}/${ENVIRONMENT}/${APP_NAME}/context.xml ${BASEDIR}/${APP_NAME}/conf

## Turn on for boot and start
chkconfig sdi.${APP_NAME} on
