#!/bin/bash
# 201406061622

### Environment setup
## Create specific sdi.${APP_NAME}.conf file with info in sdi_service_scripts/supplemental/ports.txt
## symlinked filename must conform to filename Sxx-name_of_app.sh for this template to work w/o modification
export APP_NAME=$(basename $0 | sed "s/\.sh$//g" | sed "s/^S..-//g")
. /etc/sdi/thig-settings

## Configure startup scripts for RHEL6 or RHEL7
## Tested working on 06.06.16 JCL

##RHEL6 using SysVInit symlinks to /etc/init.d/ - NOT CHANGE
if [[ $OSANDVERSION == "RHEL6" ]]
then
   ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/sdi.${APP_NAME}
##RHEL7 using Systemd target methods. Creates a .service file that links to sdi init scripts
elif [[ $OSANDVERSION == "RHEL7" ]]
then
   cp /opt/sdi/sdi_service_scripts/systemd/sdi.systemdtemplate /usr/lib/systemd/system/sdi.${APP_NAME}.service
   sed -i "s/SEDTOAPPNAME/${APP_NAME}/g" /usr/lib/systemd/system/sdi.${APP_NAME}.service
   sed -i "s/SEDTOAPPUSER/${APP_NAME}/g" /usr/lib/systemd/system/sdi.${APP_NAME}.service
   ln -s /opt/sdi/sdi_service_scripts/systemd/sdi.functionstemplate /etc/init.d/sdi.${APP_NAME}
fi

## Create the application conf file that exists in /etc/sdi
echo "PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $3 } ')
DEBUGPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt| grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $5 } ')
JMXPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $4 } ')
SHUTDOWNPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $6 } ')
MCASTPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep "${ENVIRONMENT} " | awk ' { print $7 } ')
JVMHEAPMIN=$(cat /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf | grep JVMHEAPMIN | awk -F= ' { print $2 } ')
JVMHEAPMAX=$(cat /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf | grep JVMHEAPMAX | awk -F= ' { print $2 } ')
BASEDIR=/opt
APP_NAME=${APP_NAME}
$(grep URL /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf)
" > /etc/sdi/sdi.${APP_NAME}.conf

### Prerequisites
## Install latest JDK8
if [[ ! -d /opt/java ]]
 then
  /opt/sdi/thig-server-role-build-scripts/applications/java/rhel65.java.latest.jdk8.install.sh
 fi
. /etc/sdi/sdi.${APP_NAME}.conf

/opt/sdi/thig-server-role-build-scripts/applications/tomcat/rhel65.tomcat.8.install.sh 

## Add ${APP_NAME} user
useradd -d /opt/${APP_NAME} ${APP_NAME}

## Install ${APP_NAME} WAR from Jenkins
. /etc/credentials/jenkins.credfile
wget -q --user=${JENKINS_USER} --password=${JENKINS_PASSWORD} -O /tmp/ROOT.war "${APP_URL}"
md5sum /tmp/ROOT.war
rm -f /opt/${APP_NAME}/webapps/ROOT.war
cp /tmp/ROOT.war /opt/${APP_NAME}/webapps

mkdir /var/run/${APP_NAME}
chown -R ${APP_NAME}:${APP_NAME} /var/run/${APP_NAME}

mkdir /opt/${APP_NAME}/etc

## Update startup.sh and server.xml to include debugging JPDA configs, jmx and listening ports
sed -i "s/exec \"\$PRGDIR\"\/\"\$EXECUTABLE\" start \"\$@\"//g" /opt/${APP_NAME}/bin/startup.sh
. /etc/sdi/sdi.${APP_NAME}.conf
cat << EOF >> /opt/${APP_NAME}/bin/startup.sh
export JAVA_HOME=/opt/java
export JPDA_ADDRESS=${DEBUGPORT}
export JPDA_TRANSPORT=dt_socket
export CATALINA_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=${JMXPORT} -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -XX:+UseG1GC -XX:+UseStringDeduplication -Xms${JVMHEAPMIN} -Xmx${JVMHEAPMAX} env_config_placeholder -Djava.io.tmpdir=/var/run/${APP_NAME} -Djavax.net.ssl.keyStorePassword=changeit -Djavax.net.ssl.trustStore=/opt/java/jre/lib/security/cacerts -Dconfig=/opt/${APP_NAME}/etc/config.properties"
EOF

case "${APP_NAME}" in

 rpm)
  sed -i "s/env_config_placeholder/-Denvironment=${ENVIRONMENT} -Dspring.profiles.active=appServer/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 tasknotes)
  sed -i "s/env_config_placeholder/-Dspring.profiles.active=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 policy-data-ws)
  sed -i "s/env_config_placeholder/-Dspring.profiles.active=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 citadel)
  sed -i "s/env_config_placeholder/-Dspring.profiles.active=${ENVIRONMENT},externalAccess,batchSystem -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 le-cms-services)
  sed -i "s|env_config_placeholder|-Dspring.profiles.active=${ENVIRONMENT},liveeditor -Dwebservices.baseUrl=https://le-cms-services${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2|g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 iso-cms-services)
  sed -i "s|env_config_placeholder|-Dspring.profiles.active=${ENVIRONMENT},iso -Dwebservices.baseUrl=https://iso-cms-services${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2|g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 symbility-cms-services)
  sed -i "s|env_config_placeholder|-Dspring.profiles.active=${ENVIRONMENT},symbility -Dwebservices.baseUrl=https://symbility-cms-services${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2|g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 portal)
  sed -i "s/env_config_placeholder/-Dspring.profiles.active=${ENVIRONMENT},samlSecurity -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 ivr-ws)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 symbility-ws)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT}/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 policy-ws)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 chatconfig)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 app-thig-com)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 docdir)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 insuredlogin)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 rolesmaster)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 iris)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 image-right-facade)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 cms-ws)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 flood-data-ws)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 arobase)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;
 agency-agreements)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2/g" /opt/${APP_NAME}/bin/startup.sh
 ;;

 *)
  sed -i "s/env_config_placeholder/-Dgrails.env=${ENVIRONMENT}/g" /opt/${APP_NAME}/bin/startup.sh
 ;;

esac

cat << \EOF >> /opt/${APP_NAME}/bin/startup.sh
exec "$PRGDIR"/"$EXECUTABLE" jpda start "$@"
EOF
sed -i "s/8080/${PORT}/g" /opt/${APP_NAME}/conf/server.xml
# Enhance tomcat logging to include millis
sed -i '/org.apache.catalina.valves.AccessLogValve/,+2d' /opt/${APP_NAME}/conf/server.xml
sed -i 's|</Host>|<Valve className="org.apache.catalina.valves.AccessLogValve"\r\n directory="logs" prefix="localhost_access_log." suffix=".txt"\r\n pattern="%{E M/d/y @ hh:mm:ss.S a z}t %a (%{X-Forwarded-For}i) > %A:%p\r\n \&quot;%r\&quot; %{requestBodyLength}r %D %s %B %I \&quot;%{Referer}i\&quot;\r\n \&quot;%{User-Agent}i\&quot; %u %{username}s %{sessionTracker}s"/>\r\n</Host>|g' /opt/${APP_NAME}/conf/server.xml

## Copy in jars needed for tomcat applications
cd /opt/${APP_NAME}/lib
wget -r --no-parent --reject "index.html*" -q -nH -nd http://sflgnvlms01.thig.com/inhouse/tomcat-application-libraries/${APP_NAME}/

## Disable AJP
sed -i "s/ 8009 -->/ 8009/g" /opt/${APP_NAME}/conf/server.xml
sed -i "s/AJP\/1.3\" redirectPort=\"8443\" \/>/AJP\/1.3\" redirectPort=\"8443\" \/>\r\n\r\n    -->/g" /opt/${APP_NAME}/conf/server.xml

## Change shutdown port (so multiple apps can live on one host)
sed -i "s/Server port=\"8005\"/Server port=\"${SHUTDOWNPORT}\"/g" /opt/${APP_NAME}/conf/server.xml

## Create directories for logs.thig.com to samba into
## Tested working on 11.26.13 CMH
mkdir /opt/${APP_NAME}/logs
chown -R ${APP_NAME}:${APP_NAME} /opt/${APP_NAME}/logs
mkdir /var/log/${APP_NAME}
mkdir -p /var/log/jndi_configs/${APP_NAME}
grep "/var/log/${APP_NAME}" /etc/fstab || echo "/opt/${APP_NAME}/logs              /var/log/${APP_NAME}          bind    defaults,bind   0 0" >> /etc/fstab
grep "/var/log/jndi_configs/${APP_NAME}" /etc/fstab || echo "/opt/${APP_NAME}/conf              /var/log/jndi_configs/${APP_NAME}          bind    defaults,bind   0 0" >> /etc/fstab
chown -R ${APP_NAME}:${APP_NAME} /opt/${APP_NAME}/

unalias cp &> /dev/null

. /etc/sdi/thig-settings
  rm -f /opt/${APP_NAME}/conf/context.xml
  cd /opt/${APP_NAME}/conf/
  cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/RHEL6/${ROLE}/${ENVIRONMENT}/${APP_NAME}/context.xml .

## Turn on for boot and start
##RHEL6 using chkconfig
if [[ $OSANDVERSION == "RHEL6" ]]
then
  chkconfig sdi.${APP_NAME} on
##RHEL7 using Systemd 
elif [[ $OSANDVERSION == "RHEL7" ]]
then
  systemctl enable sdi.${APP_NAME} 
fi

