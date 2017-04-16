#!/bin/bash
. /etc/sdi/thig-settings
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/winbind/system-auth /etc/pam.d/system-auth
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/winbind/system-auth /etc/pam.d/password-auth
