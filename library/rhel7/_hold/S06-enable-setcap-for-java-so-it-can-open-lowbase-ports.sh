#!/bin/bash
#
# Use the setcap capabilities to allow an executable to bind on a port below 1024
#
# From: https://gist.github.com/firstdoit/6389682
# and
# From: https://blogs.oracle.com/sduloutr/entry/binding_a_server_to_privileged
# and
# From: http://unix.stackexchange.com/questions/87978/how-to-get-oracle-java-7-to-work-with-setcap-cap-net-bind-serviceep
# 
cat << EOF >> /etc/ld.so.conf.d/java.conf 
/opt/java/lib/amd64/jli
/opt/java/jre/lib/amd64/jli
EOF
ldconfig
setcap 'cap_net_bind_service=+ep' /opt/java/bin/java
setcap -v 'cap_net_bind_service=+ep' /opt/java/bin/java
setcap 'cap_net_bind_service=+ep' /opt/java/jre/bin/java
setcap -v 'cap_net_bind_service=+ep' /opt/java/jre/bin/java

