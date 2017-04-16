#!/bin/bash
. /etc/sdi/thig-settings
if [[ -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/batchprocessing_credentials ]]
 then
  ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/batchprocessing_credentials /etc/samba/batchprocessing_credentials
 fi
