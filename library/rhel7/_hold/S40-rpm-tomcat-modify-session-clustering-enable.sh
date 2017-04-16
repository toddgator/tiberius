#!/bin/bash

source /etc/sdi/sdi.rpm.conf

sed -i "s/<Context>/<Context distributable=\"true\" className=\"org.apache.catalina.ha.context.ReplicatedContext\" >/g" /opt/rpm/conf/context.xml

# Both the lines to remove and the configuration lines to add to server.xml in
# order to enable tomcat clustering are multi-line configurations so it was
# necessary to use a more intelligent utility than sed. This reconfiguration was
# done in python.

python /opt/sdi/thig-server-role-build-scripts/library/python/enable-tomcat-clustering.py ${MCASTPORT}

chown rpm:rpm /opt/rpm/conf/server.xml
chmod 600 /opt/rpm/conf/server.xml
