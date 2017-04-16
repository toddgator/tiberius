#!/bin/bash
. /etc/sdi/thig-settings
cd /tmp
wget -q http://thirdparty.thig.com/netapp/sdu/netapp.snapdrive.linux_5_2_1.rpm
wget -q http://thirdparty.thig.com/netapp/huk/netapp_linux_host_utilities-6-2.x86_64.rpm
yum install -y --nogpgcheck /tmp/netapp.snapdrive.linux_5_2_1.rpm /tmp/netapp_linux_host_utilities-6-2.x86_64.rpm
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/pps/all/snapdrive/.sdupw /opt/NetApp/snapdrive
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/all/snapdrive/.pwfile /opt/NetApp/snapdrive
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/all/snapdrive/.vifpw /opt/NetApp/snapdrive
cp -f /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/all/snapdrive/snapdrive.conf /opt/NetApp/snapdrive
