#!/bin/bash
cat << \EOF >> /etc/oratab
#



# This file is used by ORACLE utilities.  It is created by root.sh
# and updated by the Database Configuration Assistant when creating
# a database.

# A colon, ':', is used as the field terminator.  A new line terminates
# the entry.  Lines beginning with a pound sign, '#', are comments.
#
# Entries are of the form:
#   $ORACLE_SID:$ORACLE_HOME:<N|Y>:
#
# The first and second fields are the system identifier and home
# directory of the database respectively.  The third filed indicates
# to the dbstart utility that the database should , "Y", or should not,
# "N", be brought up at system boot time.
#
# Multiple entries with the same $ORACLE_SID are not allowed.
#
#
oraprod:/u01/app/oracle/product/12.1.0/db_1:Y
orainnov:/u01/app/oracle/product/12.1.0/db_1:Y
imgprod:/u01/app/oracle/product/12.1.0/db_1:N
smrpprod:/u01/app/oracle/product/12.1.0/db_1:N
xdeprod:/u01/app/oracle/product/12.1.0/db_1:Y
EOF
