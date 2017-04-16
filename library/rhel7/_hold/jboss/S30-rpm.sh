#!/bin/bash
# 201312091500
##
# RPM specific JBOSS configuration
##
VERSION=1.0.1


##
# Environment Setup
##
export APP_NAME=rpm
. /etc/sdi/thig-settings

if [[ $ENVIRONMENT == "beta" ]]
then
 export ENVIRONMENT="uat"
fi

##
# General Settings
##
INSTALLDIR=/opt/${APP_NAME}
RUNDIR=/var/run/${APP_NAME}

JBOSSTEMPLATE=/opt/jboss-eap-6.1
JBOSSUSER=jboss
JBOSSCLASS=standalone
JBOSSCONF=${INSTALLDIR}/${JBOSSCLASS}/configuration/standalone-ha.xml
JBOSSRUNTIMECONF=${INSTALLDIR}/bin/${JBOSSCLASS}.conf


##
# Memory Settings
##
JVMHEAPMIN=5120M
JVMHEAPMAX=5120M
JVMPERMGEN=512M


##
# SDI application configuration
##



echo "PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $3 } ')
DEBUGPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $5 } ')
JMXPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep ${APP_NAME} | grep ${ENVIRONMENT} | grep -v "^#" | awk ' { print $4 } ')
ADMINPORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $6 }')
MCAST1PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $7 }')
MCAST2PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $8 }')
MCAST3PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $9 }')
BASEDIR=/opt
APP_NAME=${APP_NAME}
" > /etc/sdi/sdi.${APP_NAME}.conf

hostname -s | egrep -iq "dflgnvjboo0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29001/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29002/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29003/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "dflgnvjboy0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29004/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29005/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29006/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "qflgnvjboq0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29007/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29008/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29009/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "qflgnvjbor0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29010/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29011/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29012/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "bflgnvjbo00" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29016/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29017/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29018/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "qflgnvjbou0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29019/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29020/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29021/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "qflgnvjbop0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29022/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29023/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29024/g" /etc/sdi/sdi.${APP_NAME}.conf
hostname -s | egrep -iq "qflgnvjbog0" && sed -i -e "s/MCAST1PORT=.*/MCAST1PORT=29028/g" -e "s/MCAST2PORT=.*/MCAST2PORT=29029/g" -e "s/MCAST3PORT=.*/MCAST3PORT=29030/g" /etc/sdi/sdi.${APP_NAME}.conf


if hostname -s | grep -qi bat
 then
   sed -i "s/MCAST1PORT=.*/MCAST1PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $7 }' | cut -c2-5)/g" /etc/sdi/sdi.${APP_NAME}.conf
   sed -i "s/MCAST2PORT=.*/MCAST2PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $8 }' | cut -c2-5)/g" /etc/sdi/sdi.${APP_NAME}.conf
   sed -i "s/MCAST3PORT=.*/MCAST3PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt|grep ${APP_NAME} | grep $ENVIRONMENT | grep -v "^#" |awk ' { print $9 }' | cut -c2-5)/g" /etc/sdi/sdi.${APP_NAME}.conf
fi

##
# Clone JBOSS from the template and inject oracle libraries
##
cp -parf $JBOSSTEMPLATE ${JBOSSTEMPLATE}.${APP_NAME}
ln -s ${JBOSSTEMPLATE}.${APP_NAME} $INSTALLDIR

useradd -m -d /opt/rpm jboss
cp -r /etc/skel/. /opt/rpm
chown -R ${JBOSSUSER}:${JBOSSUSER} ${JBOSSTEMPLATE}.${APP_NAME}

# Oracle jar is required at both the jar and container level
cp /opt/libs/oracle/oracle-11.1.0.6.0.jar ${INSTALLDIR}/${JBOSSCLASS}/lib/ext/


##
# JBOSS network configuration
##
# Update ports in configuration files based on environment
. /etc/sdi/sdi.${APP_NAME}.conf
sed -i "s/port=\"8080/port=\"${PORT}/g" $JBOSSCONF
sed -i "s/jboss.management.http.port:9990/jboss.management.http.port:${ADMINPORT}/g" $JBOSSCONF
sed -i "s/jboss.management.native.port:9999/jboss.management.native.port:${JMXPORT}/g" $JBOSSCONF
sed -i "s/multicast-port=\"23364\"/multicast-port=\"${MCAST1PORT}\"/g" $JBOSSCONF
sed -i "s/multicast-port=\"45700\"/multicast-port=\"${MCAST2PORT}\"/g" $JBOSSCONF
sed -i "s/multicast-port=\"45688\"/multicast-port=\"${MCAST3PORT}\"/g" $JBOSSCONF

# Change binding address to support multicast, JBOSS doesn't start without this
IPADDRESS=$(ifconfig eth0 | grep inet | grep -v inet6 | awk '{print $2}' | sed "s/addr://g")
sed -i "s/<inet-address value=\"\${jboss.bind.address:127.0.0.1/<inet-address value=\"\${jboss.bind.address:${IPADDRESS}/g" $JBOSSCONF
sed -i "s/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:${IPADDRESS}/g" $JBOSSCONF


##
# JBOSS runtime configuration
##
# Remove jaxrs subsystem per [http://stackoverflow.com/questions/6953516/deploying-a-jersey-webapp-on-jboss-as-7 Jersey Webapp restrictions] and [https://issues.jboss.org/browse/WFLY-831 Wildfly bug]
sed -i "s/.*jaxrs.*//g" $JBOSSCONF
# Disable default root application
sed -i "s/enable-welcome-root=\"true\"/enable-welcome-root=\"false\"/g" $JBOSSCONF
# Modify JAVA_OPTS to change memory size and bind addresses.   Bind address CANNOT be all IPs (0.0.0.0) when using ha/clustering, it is required to be real IP.
# -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2 for outbound SSL negotiation w/ Java 7
# -Dspring.profiles.active=appServer for Venkat's request for them to be able to debug code in production without pulling messages off the queue and likely breaking something.
  sed -i "s/JAVA_OPTS=\"-Xms1303m .*$/JAVA_OPTS=\"-Djava.io.tmpdir=\/var\/run\/rpm -Xms${JVMHEAPMIN} -Xmx${JVMHEAPMAX} -XX:MaxPermSize=${JVMPERMGEN} -Dhttps.protocols=TLSv1,TLSv1.1,TLSv1.2 -Dspring.profiles.active=appServer -Djava.net.preferIPv4Stack=true -Djavax.net.ssl.keyStorePassword=changeit -Djavax.net.ssl.trustStore=\/opt\/java\/jre\/lib\/security\/cacerts -Dgrails.env=${ENVIRONMENT} -Dconfig=\/opt\/rpm\/etc\/config.properties -Denvironment=${ENVIRONMENT} -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=${DEBUGPORT} -Dspring.profiles.active=appServer\"/g" $JBOSSRUNTIMECONF

#Per DWatson troubleshooting error "java.sql.SQLException: SyncProvider instance not constructed" :: https://community.jboss.org/thread/228528?_sscc=t
sed -i "s/security\/auth\/module\"\/>/security\/auth\/module\"\/>\n\t\t<path name=\"com\/sun\/rowset\"\/>\n\t\t<path name=\"com\/sun\/rowset\/internal\"\/>\n\t\t<path name=\"com\/sun\/rowset\/providers\"\/>/g" ${INSTALLDIR}/modules/system/layers/base/sun/jdk/main/module.xml

#Create the admin user for the jboss admin web-ui
sed -i "s/JAVA=\"java\"/JAVA=\"\/opt\/java\/bin\/java\"/g" ${INSTALLDIR}/bin/add-user.sh 
${INSTALLDIR}/bin/add-user.sh -s jboss 4nts-taste-better-than-flies


##
# Update directory structure
##
# Make the directory for config.properties
mkdir -p ${INSTALLDIR}/etc

# Create directories for logs.thig.com mounting and exporting
mkdir -p $RUNDIR
mkdir -p ${INSTALLDIR}/logs
chown -R ${JBOSSUSER}:${JBOSSUSER} ${INSTALLDIR}/logs
chown -R ${JBOSSUSER}:${JBOSSUSER} $RUNDIR
mkdir -p /var/log/jboss.${APP_NAME}
mkdir -p /var/log/${APP_NAME}
mkdir -p ${INSTALLDIR}/standalone/log
grep "/var/log/jboss" /etc/fstab || echo "${INSTALLDIR}/${JBOSSCLASS}/log              /var/log/jboss.${APP_NAME}         bind    defaults,bind   0 0" >> /etc/fstab
grep "/var/log/${APP_NAME}" /etc/fstab || echo "${INSTALLDIR}/logs              /var/log/${APP_NAME}          bind    defaults,bind   0 0" >> /etc/fstab


##
# Setup the init script, perform the initial deployment of the current production release
##
ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/sdi.${APP_NAME}
chkconfig --add sdi.${APP_NAME}
