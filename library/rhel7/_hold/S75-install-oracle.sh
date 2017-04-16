#!/bin/bash
cd /
wget http://thirdparty.thig.com/oracle/oracle-base-production.tgz
tar xvzf oracle-base-production.tgz
chown -R oracle:oracle /u01
chmod 6751 /u01/app/oracle/product/11.2.0/db_1/bin/oracle
