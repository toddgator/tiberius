#!/bin/bash
. /etc/sdi/thig-settings
cd /usr/lib/ocf/resource.d/heartbeat
curl -O https://raw.githubusercontent.com/thisismitch/cluster-agents/master/haproxy
chmod +x haproxy
rm -f /etc/haproxy/haproxy.cfg
cp /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/haproxy.cfg /etc/haproxy
