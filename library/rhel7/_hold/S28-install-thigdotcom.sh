#!/bin/bash
#


. /etc/sdi/thig-settings
. /etc/sdi/thig-functions

cp /opt/sdi/sdi_service_scripts/templates/sdi.thigdotcom.conf /etc/sdi


cd /tmp
    if [ ! -f /usr/lib64/libtdsodbc.so ];
       then
         echo "Error Oracle not installed correctly"
         oracle_connectors
     fi
      adduser -d /opt/thigdotcom thigdotcom
      su - thigdotcom -c "virtualenv Python2.6.6
      echo 'source ~/Python2.6.6/bin/activate
      export ORACLE_HOME=/usr/lib/oracle/11.2/client64
      export LD_LIBRARY_PATH=\$ORACLE_HOME/lib' >> ~/.bash_profile
      . ~/.bash_profile
      easy_install cx_Oracle
        pip install Beaker==1.5.4
        pip install Chameleon==2.0-rc8
        pip install FormEncode==1.2.4
        pip install Mako==0.4.1
        pip install Markdown==2.0.3
        pip install MarkupSafe==0.12
        pip install MySQL-python==1.2.3
        pip install Paste==1.7.5.1
        pip install PasteDeploy==1.3.4
        pip install PasteScript==1.7.3
        pip install Pygments==1.4
        pip install SQLAlchemy==0.6.7
        pip install Tempita==0.5dev
        pip install WebError==0.10.3
        pip install WebHelpers==1.3
        pip install WebOb==1.0.7
        pip install inflect==0.2.1
        pip install ordereddict==1.1
        pip install pyodbc==2.1.8 --allow-external pyodbc --allow-unverified pyodbc
        pip install pyramid==1.0
        pip install pyramid-beaker==0.5
        pip install pyramid-simpleform==0.6.1
        pip install repoze.lru==0.3
        pip install repoze.tm2==1.0b1
        pip install transaction==1.1.1
        pip install translationstring==0.3
        pip install unittest2==0.5.1
        pip install venusian==0.8
        pip install zope.component==3.10.0
        pip install zope.configuration==3.7.4
        pip install zope.deprecation==3.4.0
        pip install zope.event==3.5.0-1
        pip install zope.i18nmessageid==3.5.3
        pip install zope.interface==3.6.1
        pip install zope.schema==3.8.0
        pip install zope.sqlalchemy==0.6.1"

cd /opt/thigdotcom
rm -f python-current.tar.gz
wget http://sflgnvlms01.thig.com/inhouse/thigdotcom/python/python-current.tar.gz
if [[ "${ENVIRONMENT}" == "beta" ]]
 then
   ENVIRONMENT=production
fi
TARGET=$(tar tvzf /opt/thigdotcom/python-current.tar.gz |grep ${ENVIRONMENT}.ini | awk '{print $6}')
    tar xvzf /opt/thigdotcom/python-current.tar.gz $TARGET
    mv ${ENVIRONMENT}.ini ${ENVIRONMENT}.ini.$(date +%Y%m%d%H%M)
    mv $TARGET ${ENVIRONMENT}.ini
    chown thigdotcom:thigdotcom ${ENVIRONMENT}.ini
    su - thigdotcom -c "/opt/thigdotcom/Python2.6.6/bin/easy_install /opt/thigdotcom/python-current.tar.gz"

. /etc/sdi/thig-settings
ln -s /opt/sdi/sdi_service_scripts/init/sdi.thigdotcom /etc/init.d/
chkconfig sdi.thigdotcom on

