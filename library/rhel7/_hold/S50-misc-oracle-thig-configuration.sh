#!/bin/bash

for x in /oradata/innovation /oradata/pdf /oradata/pdf2 /oradata/proddata /oraarchlogs /oracontrolfiles /backups/innovation_bak /controlfiles/oraprod /controlfiles/orainnov /oradata/xdeprod /archivelogs/xdeprod /controlfiles/xdeprod /orabackups /metadata /opt/util;
do
  mkdir -p $x
  chown -R oracle:oracle $x
done
  chown -R oracle:oracle /oradata/ /backups/ /controlfiles/ /archivelogs/

cd /opt/util
for x in `find /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/opt_util/*`;
do 
  ln -s $x
done
  

