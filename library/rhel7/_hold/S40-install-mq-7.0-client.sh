#!/bin/bash
mkdir -p /tmp/mq_license/license/
touch /tmp/mq_license/license/status.dat
yum -y install sharutils glibc.i686
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesRuntime-7.0.0-1.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesClient-7.0.0-1.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesSDK-7.0.0-1.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesRuntime-U847971-7.0.1-8.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesSDK-U847971-7.0.1-8.x86_64.rpm
rpm -Uvh http://thirdparty.thig.com/IBM/MQ-7.0.1.8/MQSeriesClient-U847971-7.0.1-8.x86_64.rpm
