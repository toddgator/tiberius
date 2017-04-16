#!/bin/bash
#
# Installs 'yum-plugin-delay' package

su - sdi -c "cd /opt/sdi;git clone https://github.com/dagwieers/yum-plugin-delay.git"
cd /opt/sdi/yum-plugin-delay
make install
