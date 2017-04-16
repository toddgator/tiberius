#!/bin/bash

if [[ `cat /etc/redhat-release | grep "6.5"` ]]; then exit
else
	echo "exclude=check-mk-agent" >> /etc/yum.conf
	yum -y update
fi
