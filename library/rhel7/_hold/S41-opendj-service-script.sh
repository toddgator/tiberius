#!/bin/bash
cd /etc/init.d/
ln -s /opt/sdi/sdi_service_scripts/init/sdi.opendj /etc/init.d/opendj
ln -s /opt/sdi/sdi_service_scripts/init/sdi.opendj
chown -R opendj:forgerock /opt/forgerock/opendj
chkconfig --add opendj
