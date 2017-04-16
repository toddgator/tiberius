#!/bin/bash
# Unpack oracle tgz
cd /
wget http://thirdparty.thig.com/oracle/oracle-base-production.tgz
tar xvzf oracle-base-production.tgz
chown -R oracle:oracle /u01

rm -f /oracle-base-production.tgz 

