#!/bin/bash
cd /tmp
wget "http://thirdparty.thig.com/netapp/smo/netapp.smo.linux-x64-3.3.1P1.bin"
chmod +x netapp.smo.linux-x64-3.3.1P1.bin
echo "SMO needs to be installed by running /tmp/netapp.smo.linux-x64-3.3.1P1.bin" >> /etc/motd
echo "someone in the future, please automate this" >> /etc/motd
