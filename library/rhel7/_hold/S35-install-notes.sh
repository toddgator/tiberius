#!/bin/bash

BASEDIR=/opt
APP_NAME=notes

. /etc/sdi/thig-settings

    cd /tmp
    adduser -d "${BASEDIR}/${APP_NAME}" ${APP_NAME}
    chkconfig --add ${APP_NAME}
    cp /opt/sdi/sdi_service_scripts/templates/sdi.${APP_NAME}.conf /etc/sdi

    if [ ! -f /usr/lib64/libtdsodbc.so ];
       then
         echo "Error Oracle not installed correctly"
         oracle_connectors
     fi
   
    su - ${APP_NAME} -c "virtualenv Python2.6.6
    echo 'source ~/Python2.6.6/bin/activate
    export ORACLE_HOME=/usr/lib/oracle/11.2/client64
    export LD_LIBRARY_PATH=\$ORACLE_HOME/lib' >> ~/.bash_profile
    . ~/.bash_profile"

    cd "${BASEDIR}/${APP_NAME}"
    rm -f python-current.tar.gz
    ## How to change this to Jenkins?
    ##
    wget http://sflgnvlms01.thig.com/inhouse/${APP_NAME}/${APP_NAME}-current.tar.gz

    cp /opt/sdi/thig-application-configs-global/roles/wab/${ENVIRONMENT}/${APP_NAME}_${ENVIRONMENT}.ini /opt/${APP_NAME}/${APP_NAME}_${ENVIRONMENT}.ini
    chown ${APP_NAME}:${APP_NAME} ${APP_NAME}_${ENVIRONMENT}.ini
    su - ${APP_NAME} -c "pip install --no-deps Beaker==1.5.4
		pip install --no-deps FormEncode==1.2.4
		pip install --no-deps Mako==0.4.2
		pip install --no-deps MarkupSafe==0.15
		pip install --no-deps Paste==1.7.5.1
		pip install --no-deps PasteDeploy==1.5.0
		pip install --no-deps PasteScript==1.7.4.2
		pip install --no-deps Pygments==1.4
		pip install --no-deps Pylons==0.9.7
		pip install --no-deps Routes==1.12.3
		pip install --no-deps SQLAlchemy==0.5.8
		pip install --no-deps Tempita==0.5.1
		pip install --no-deps WebError==0.10.3
		pip install --no-deps WebHelpers==1.3
		pip install --no-deps WebOb==0.9.8
		pip install --no-deps WebTest==1.3
		pip install --no-deps cx-Oracle==5.1.3 --allow-unverified cx_Oracle
		pip install --no-deps decorator==3.3.2
		pip install --no-deps nose==1.1.2
		pip install --no-deps simplejson==2.2.1
		pip install --no-deps virtualenv==1.6.4
		pip install --no-deps wsgiref==0.1.2
		pip install --no-deps ${APP_NAME}-current.tar.gz"

ln -s /opt/sdi/sdi_service_scripts/init/sdi.${APP_NAME} /etc/init.d/
chkconfig sdi.notes on

. /etc/sdi/thig-settings


mkdir /var/log/notes
echo '/opt/notes              /var/log/notes          bind    defaults,bind   0 0' >> /etc/fstab
cd /opt/notes
chmod +rx .
