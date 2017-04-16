#!/bin/bash

. /etc/sdi/thig-settings
echo "//documentengine/docs_${ENVIRONMENT}/input/pps          /srv/pro4/data/megdata/docs/ cifs defaults,acl,noperm,credentials=/etc/samba/docs_${ENVIRONMENT}_credentials,_netdev 0 0" >> /etc/fstab
ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/${ENVIRONMENT}/samba/docs_${ENVIRONMENT}_credentials /etc/samba/docs_${ENVIRONMENT}_credentials
