#!/bin/bash
mkdir -p /tmp/mq_license_7.5.0/license/
cat << EOF >> /tmp/mq_license_7.5.0/license/status.dat 
#Fri Sep 26 15:19:47 EDT 2014
Status=9
EOF
# Next line requires rhel optional channel?
rpm -Uvh http://mirror.centos.org/centos/6/os/x86_64/Packages/sharutils-4.7-6.1.el6.x86_64.rpm

rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.5.0.4/MQSeriesRuntime-7.5.0-4.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.5.0.4/MQSeriesClient-7.5.0-4.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.5.0.4/MQSeriesSDK-7.5.0-4.x86_64.rpm
