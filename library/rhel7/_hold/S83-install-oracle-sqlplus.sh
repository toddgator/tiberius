#!/bin/bash
rpm -Uvh http://thirdparty.thig.com/oracle/oracle-instantclient11.2-sqlplus-11.2.0.3.0-1.x86_64.rpm
echo 'export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/lib
' >> /etc/profile
