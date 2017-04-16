#!/bin/bash
cat << \EOF >> /etc/sdi/thig-functions
# -*-Shell-script-*-
#
# functions     This file contains functions to be used by most or all
#               shell scripts in the /etc/init.d directory.
#

oracle_connectors() {
    yum -y install unixODBC-devel.x86_64 mysql-devel.x86_64 mysql-connector-odbc.x86_64
    rpm -Uvh http://thirdparty.thig.com/epel/freetds-0.64-1.el5.rf.x86_64.rpm
    rpm -Uvh http://thirdparty.thig.com/oracle/oracle-instantclient11.2-basic-11.2.0.3.0-1.x86_64.rpm
    rpm -Uvh http://thirdparty.thig.com/oracle/oracle-instantclient11.2-devel-11.2.0.3.0-1.x86_64.rpm

    ln /usr/lib64/libtdsodbc.so.0 /usr/lib64/libtdsodbc.so

echo '# FreeTDS Driver
[FreeTDS]
Description = TDS driver (Sybase/MS SQL)
Driver      = /usr/lib64/libtdsodbc.so
Setup       = /usr/lib64/libtdsS.so
CPTimeout   =
CPReuse     =
' > /etc/odbcinst.ini

} 

EOF
