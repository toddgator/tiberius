#!/bin/bash

rpm -Uvh http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
echo 'export ORACLE_HOME=/usr/lib/oracle/12.1/client64
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/lib
' >> /etc/profile
