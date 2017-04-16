#!/bin/bash
# 201311201433

cd /tmp
rm -f jdk*
wget -q http://thirdparty.thig.com/sun/java/jdk/jdk7-latest.tar.gz
tar xvzf jdk7-latest.tar.gz
mv $(ls /tmp/ | grep jdk1.7) /opt
cd /opt
rm -f java
ln -s $(ls | grep jdk1.7) java
grep JAVA_HOME /etc/profile && echo "!! JAVA_HOME Already set!!"
grep JAVA_HOME /etc/profile || sed -i 's/unset i/export JAVA_HOME=\/opt\/java\nexport PATH=$PATH:\/opt\/java\/bin\n\nunset i/g' /etc/profile
. /etc/profile
rm -f /opt/java/jre/lib/security/cacerts
cp /opt/sdi/thig-application-configs-global/credentials/javakeystore/java.install.cacerts.keystore /opt/java/jre/lib/security/cacerts
