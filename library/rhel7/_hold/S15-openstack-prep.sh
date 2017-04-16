#!/bin/bash

. /etc/sdi/thig-settings

cd /opt/forgerock

# Add OPENDJ_JAVA_HOME per OpenDJ install guide: https://backstage.forgerock.com/docs/opendj/3.5/install-guide#chap-install
echo 'export OPENDJ_JAVA_HOME=/opt/java' >> /etc/profile


mkdir /opt/forgerock/sources
cd  /opt/forgerock/sources

mkdir opendj
cd opendj
wget "http://thirdparty.thig.com/forgerock/2017/opendj-latest-2017.zip"
unzip opendj-latest-2017.zip
cd ..

mkdir openam
cd openam
wget "http://thirdparty.thig.com/forgerock/2017/openam-latest-2017.zip"
unzip openam-latest-2017.zip
cd ..
