#!/bin/bash


APP_NAME=$(basename $0 | sed "s/S..-install-//g" | sed "s/.sh//g")
cp /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf /etc/sdi

. /etc/sdi/thig-settings
. /etc/sdi/sdi.${APP_NAME}.conf

   cd /tmp
   echo $APP_NAME
   APP_HOME=${BASEDIR}/${APP_NAME}
   ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/sdi.${APP_NAME}
   APP_URL=$(cat /opt/sdi/sdi_service_scripts/supplemental/urls.txt | grep "${APP_NAME}" | awk ' { print $2 } ')

   cp -parf /opt/jetty_817 /opt/jetty_817.${APP_NAME}
   ln -s /opt/jetty_817.${APP_NAME} /opt/${APP_NAME}
   rm -f /opt/${APP_NAME}/contexts/test*

    curl -s -u svc_sdi_deploy:f4nt4sticSt4rDestroyer -o ${APP_HOME}/webapps/ROOT.war ${APP_URL}
    chkconfig --add ${APP_NAME}
    chkconfig sdi.${APP_NAME} on
    grep "\[$APP_NAME\]" /etc/samba/smb.conf 1>/dev/null 2>&1 || cat << EOF >> /etc/samba/smb.conf
[$APP_NAME]
     path = /opt/$APP_NAME/
     valid users = @"THIG-DOMAIN+Team Synergy", @"THIG-DOMAIN+Linux Admins",
     read only = yes
     browseable = yes
     force user = root
EOF
    service sernet-samba-smb reload
    mkdir /var/run/$APP_NAME
    chown jetty:jetty /var/run/$APP_NAME

    sed -i "s/^THIG_ENV=.*/THIG_ENV=\"$app_environment\"/g" ${APP_HOME}/bin/jetty.sh
    echo sed -i "s/^THIG_ENV=.*/THIG_ENV=\"$app_environment\"/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^APPLICATION=.*/APPLICATION="$APP_NAME"/g" ${APP_HOME}/bin/jetty.sh
    echo  sed -i "s/^APPLICATION=.*/APPLICATION="$APP_NAME"/g" ${APP_HOME}/bin/jetty.sh
    
    sed -i "s/PORT=.*/PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep "${APP_NAME}" | grep -i "${app_environment}" | awk ' { print $3 } ')/g" /etc/sdi/sdi.${APP_NAME}.conf
    _JETTY_PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep "${APP_NAME}" | grep -i "${app_environment}" | awk ' { print $3 } ')
    _JMX_PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep "${APP_NAME}" | grep -i "${app_environment}" | awk ' { print $4 } ')
    _DEBUG_PORT=$(cat /opt/sdi/sdi_service_scripts/supplemental/ports.txt | grep "${APP_NAME}" | grep -i "${app_environment}" | awk ' { print $5 } ')
    _HEAP_ALLOCATION=$(cat /opt/sdi/sdi_service_scripts/supplemental/memory.txt | grep "${APP_NAME}" | awk ' { print $2 } ')
    _PERM_GEN=$(cat /opt/sdi/sdi_service_scripts/supplemental/memory.txt | grep "${APP_NAME}" | awk ' { print $3 } ')
    _MAX_PERM_GEN=$(cat /opt/sdi/sdi_service_scripts/supplemental/memory.txt | grep "${APP_NAME}" | awk ' { print $4 } ')
    sed -i "s/^JETTY_PORT=.*/JETTY_PORT=${_JETTY_PORT}/g" ${APP_HOME}/bin/jetty.sh
    echo sed -i "s/^JETTY_PORT=.*/JETTY_PORT=${_JETTY_PORT}/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^JMX_PORT=.*/JMX_PORT=${_JMX_PORT}/g" ${APP_HOME}/bin/jetty.sh
    echo sed -i "s/^JMX_PORT=.*/JMX_PORT=${_JMX_PORT}/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^DEBUG_PORT=.*/DEBUG_PORT=${_DEBUG_PORT}/g" ${APP_HOME}/bin/jetty.sh    
    #sed -i "s/^JAVA_HOME=.*/JAVA_HOME=\/opt\/java;JAVA=\/opt\/java\/bin\/java/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^HEAP_ALLOCATION=.*/HEAP_ALLOCATION=${_HEAP_ALLOCATION}/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^PERM_GEN=.*/PERM_GEN=${_PERM_GEN}/g" ${APP_HOME}/bin/jetty.sh
    sed -i "s/^MAX_PERM_GEN=.*/MAX_PERM_GEN=${_MAX_PERM_GEN}/g" ${APP_HOME}/bin/jetty.sh
    echo sed -i "s/^MAX_PERM_GEN=.*/MAX_PERM_GEN=${_MAX_PERM_GEN}/g" ${APP_HOME}/bin/jetty.sh
    chmod +x ${APP_HOME}/bin/jetty.sh
    chown -R jetty:jetty ${APP_HOME}
    echo "Header variables of ${APP_HOME}/bin/jetty.sh -- these should be populated as expected."
    grep -v "#" ${APP_HOME}/bin/jetty.sh | grep "=" | head -15
   echo grep -v "#" ${APP_HOME}/bin/jetty.sh | grep "=" | head -15
    ln -s /opt/$APP_NAME/logs /var/log/$APP_NAME



