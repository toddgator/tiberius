#!/usr/bin/env bash


FTPACCOUNTS="ftpsecure eftlockbox eft_admin svc_eft.thig.com sungard wellsfargo millennium idepot allcat bandh usadjust ACC CNC Pacesetters NCA Mathias ISAC HBC Wardlaw AMCAT worley rjmw amcat hollie iscs innov_admin DRC dba ftpbackup thig netapp usps ppsadmin pentaho svc_latitude oir citizens_submissions ivantage"

# For all the accounts in the $FTPACCOUNTS list read their shadow configuration
# line from the application-configs repo and overwrite the current configuration
# line in /etc/shadow so that the passwords will remain the same as on the
# existing server.
for account in ${FTPACCOUNTS}; do
  OLD_SHADOW_ENTRY=$(cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/shadow | grep "^${account}")
  sed -i -e "s ${account}.* ${OLD_SHADOW_ENTRY} g" /etc/shadow
done
