#!/bin/bash
if [[ -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/rpm_to_ir_cold_credentials ]]
 then
  ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/rpm_to_ir_cold_credentials /etc/samba/rpm_to_ir_cold_credentials
 fi

