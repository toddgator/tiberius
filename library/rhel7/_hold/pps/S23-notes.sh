#!/bin/bash
. /etc/sdi/thig-settings
mkdir /etc/notes
cp -v /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/all/notes/environment.ini /etc/notes/environment.ini
