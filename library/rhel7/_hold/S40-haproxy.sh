#!/bin/bash
cd /tmp
yum -y install openssl-devel pcre-devel 
mkdir haproxy-src
cd haproxy-src
wget http://www.haproxy.org/download/1.6/src/haproxy-1.6.7.tar.gz
tar xvzf haproxy-1.6.7.tar.gz
cd ./haproxy-1.6.7
make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_CRYPT_H=1 USE_LIBCRYPT=1 ARCH=native
make install
unalias cp
#Copy the haproxy binaries to /usr/sbin
cp /usr/local/sbin/haproxy /usr/sbin/
#Copy the example init file for haproxy to the init directory.
cp /tmp/haproxy-src/haproxy-1.6.7/examples/haproxy.init /etc/init.d/haproxy
#Modify the file permissions of the init file.
chmod 755 /etc/init.d/haproxy
#Create a user for haproxy.
useradd --system haproxy
#Create an haproxy /etc directory to store configuration files.
mkdir -p /etc/haproxy

chkconfig haproxy on
