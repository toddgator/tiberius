#!/bin/bash
yum -y install ksh compat-libcap1.x86_64 compat-libstdc++-33.x86_64
rpm -Uvh http://thirdparty.thig.com/legato/libXp-1.0.0-8.1.el5.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/legato/lgtoclnt-8.0.1.1-1.x86_64.rpm
