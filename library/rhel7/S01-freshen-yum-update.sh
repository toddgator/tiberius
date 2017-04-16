#!/bin/bash
#
#	Update all sysstem packages installed so far(except exclusions).

if [[ `cat /etc/redhat-release | grep "6.5"` ]]; then exit
else
	## 'exclude=check-mk-agent' disables updating of check-mk-agent package
	echo "exclude=check-mk-agent" >> /etc/yum.conf
	yum -y update
fi
