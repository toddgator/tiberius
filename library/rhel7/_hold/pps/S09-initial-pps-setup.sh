#!/usr/bin/env bash

. /etc/sdi/thig-settings

yum install -y xorg-x11-apps xorg-x11-xauth telnet-server
yum install -y python-paramiko
wget -q http://sflgnvlms01.thig.com/inhouse/oracle/xfu -O /usr/local/bin/xfu
chmod +x /usr/local/bin/xfu

# Update telnet session limits for PPS
gawk -F "=" 'BEGIN{OFS="="} $1 ~ "disable" { $2 = " no" } { print }' /etc/xinetd.d/telnet > /tmp/telnet && mv /tmp/telnet /etc/xinetd.d/telnet
gawk -F "=" 'BEGIN{OFS="="} $1 ~ "instances" { $2 = "500" } { print }' /etc/xinetd.conf > /tmp/xinetd.conf && mv /tmp/xinetd.conf /etc/xinetd.conf
gawk -F "=" 'BEGIN{OFS="="} $1 ~ "per_source" { $2 = "100" } { print }' /etc/xinetd.conf > /tmp/xinetd.conf && mv /tmp/xinetd.conf /etc/xinetd.conf

# Git checkout the pps_scripts repo and switch to the RHEL6 branch
su - sdi -c "cd /opt/sdi;git clone git@github.thig.com:IT-Operations/pps_scripts.git;cd pps_scripts;git checkout rhel6;git pull"