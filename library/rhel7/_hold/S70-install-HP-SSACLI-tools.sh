#!/bin/bash
#This is to install the below "HP Enterprise Smart Storage Administrator CLI" utilities:
#
# 1 - HPE SSA CLI for Linux 64 bit - ssacli-2.60-19.0.x86_64.rpm
# Source: http://h20564.www2.hpe.com/hpsc/swd/public/detail?sp4ts.oid=5194969&swItemId=MTX_3d16386b418a443388c18da82f&swEnvOid=4103#tab3
#
# 2 - HEP SSA Diagnostics Utility for Linux 64 bit - ssaducli-2.60-18.0.x86_64.rpm
# Source: http://h20564.www2.hpe.com/hpsc/swd/public/detail?sp4ts.oid=5177954&swItemId=MTX_85f8ce7d2ce84add9f7d3e3d3a&swEnvOid=4103

mkdir -p /opt/HP_Enterprise_SSACLI_tools
cd /opt/HP_Enterprise_SSACLI_tools
wget http://sflgnvlms01.thig.com/inhouse/HP_Enterprise_SSACLI_tools/ssacli-2.60-19.0.x86_64.rpm
wget http://sflgnvlms01.thig.com/inhouse/HP_Enterprise_SSACLI_tools/ssaducli-2.60-18.0.x86_64.rpm

rpm -ivh /opt/HP_Enterprise_SSACLI_tools/ssacli-2.60-19.0.x86_64.rpm
rpm -ivh /opt/HP_Enterprise_SSACLI_tools/ssaducli-2.60-18.0.x86_64.rpm
