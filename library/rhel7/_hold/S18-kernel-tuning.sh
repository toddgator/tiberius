#!/bin/bash
##
# Configure socket buffers
##
sed -i "s/net.core.rmem_max.*//g" /etc/sysctl.conf
sed -i "s/net.core.wmem_max.*//g" /etc/sysctl.conf

grep "net.core.rmem_max" /etc/sysctl.conf || cat << EOF >> /etc/sysctl.conf
# increase TCP max buffer size settable using setsockopt()
net.core.rmem_max = 26424115
net.core.wmem_max = 26424115
# increase Linux autotuning TCP buffer limit
net.ipv4.tcp_rmem = 4096 87380 26424115
net.ipv4.tcp_wmem = 4096 65536 26424115
EOF
sysctl -p
