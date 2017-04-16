#!/bin/bash
cd /opt/forgerock
wget -O scripts-latest.zip http://thirdparty.thig.com/forgerock/scripts-latest.zip
unzip -o scripts-latest.zip
rm -f scripts-latest.zip

. /etc/sdi/thig-settings
cd /opt/forgerock/scripts
chgrp -R forgerock /opt/forgerock/scripts
chmod -R g+rw /opt/forgerock/scripts
mkdir /opt/forgerock/sources
cd  /opt/forgerock/sources
wget "http://thirdparty.thig.com/forgerock/openam-latest.war"
wget "http://thirdparty.thig.com/forgerock/opendj-latest.zip"
wget "http://thirdparty.thig.com/forgerock/SSOConfiguratorTools-latest.zip"
wget "http://thirdparty.thig.com/forgerock/openidm-latest.zip"
wget "http://thirdparty.thig.com/forgerock/scripts-latest.zip"
wget "http://thirdparty.thig.com/forgerock/SSOAdminTools-latest.zip"
wget "http://thirdparty.thig.com/forgerock/cts-latest.zip"
wget "http://thirdparty.thig.com/forgerock/opendj-accountchange-handler-1.0.3.zip"

cd ..
mkdir tools
cd tools
mkdir SSOConfiguratorTools
cd SSOConfiguratorTools
unzip -o ../../sources/SSOConfiguratorTools-latest.zip
cd ..
mkdir cts
cd cts
unzip -o ../../sources/cts-latest.zip
cd ..
mkdir opendj-accountchange-handler
unzip -o /opt/forgerock/sources/opendj-accountchange-handler-1.0.3.zip
