#!/bin/bash
. /etc/sdi/thig-settings
cd /etc/ha.d/
rm -f /etc/ha.d/ldirectord.cf
ln -sf /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/ldirectord.cf
echo "$(date) /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/ldirectord.cf symlinked to /etc/ha.d/ldirectord.cf" >> /var/log/thig_symlinks.log
