#!/bin/bash

. /etc/sdi/thig-settings
   yum -y install python-devel unixODBC-devel.x86_64 mysql-connector-odbc.x86_64 freetds --exclude openssl --skip-broken

if [[ $OSANDVERSION == "RHEL7" ]]
then
   rpm -Uvh http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/MySQL-devel-5.6.26-1.el7.x86_64.rpm

   rpm -Uvh http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
   rpm -Uvh http://sflgnvcfs02.thig.com/thiglocalmirror/third-party/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

elif [[ $OSANDVERSION == "RHEL6" ]]
then
   yum -y install mysql-devel.x86_64
   rpm -Uvh http://thirdparty.thig.com/oracle/oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm
   rpm -Uvh http://thirdparty.thig.com/oracle/oracle-instantclient11.2-devel-11.2.0.3.0-1.x86_64.rpm
fi

    ln /usr/lib64/libtdsodbc.so.0 /usr/lib64/libtdsodbc.so

    cat << EOF >> /etc/odbcinst.ini
# FreeTDS Driver
[FreeTDS]
Description = TDS driver (Sybase/MS SQL)
Driver      = /usr/lib64/libtdsodbc.so
Setup       = /usr/lib64/libtdsS.so
CPTimeout   =
CPReuse     =
EOF

