#!/bin/bash
cat << EOF >> /etc/sysctl.conf
# Next four lines prevent http server farm members from arping for the virtual farm service address
net.ipv4.conf.eth0.arp_ignore = 1
net.ipv4.conf.eth0.arp_announce = 2
net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 2
EOF

sysctl -p
