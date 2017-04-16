#!/bin/bash
. /etc/sdi/thig-settings
mkdir /mnt/wordpress
ln -s /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/credentials /etc/samba/credentials
echo $environment | grep dmz || echo '//gnvnetapp01/thigdotcom_assets /mnt/wordpress cifs defaults,rw,acl,noreservation,noperms,noatime,nodiratime,credentials=/etc/samba/credentials,rsize=16384,wsize=16384,_netdev 0 0' >> /etc/fstab
echo $environment | grep dmz && echo 'xflgnvcfs01:/srv/www /mnt/wordpress nfs defaults,rw,acl,noatime,nodiratime,rsize=65536,wsize=65536,_netdev 0 0' >> /etc/fstab
