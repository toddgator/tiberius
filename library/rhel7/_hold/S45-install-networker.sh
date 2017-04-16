#!/bin/bash
yum -y install ksh libc.so.6
rpm -Uvh http://thirdparty.thig.com/legato/libXp-1.0.0-8.1.el5.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/legato/lgtoclnt-8.2.2-1.x86_64.rpm
chkconfig networker on
