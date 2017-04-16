#!/bin/bash
#
# Adding samba configuration for mounting dfs shares.

echo '#FROM http://mikemstech.blogspot.com/2012/10/how-to-mount-dfs-share-in-linux.html - these are known required for samba4' >> /etc/request-key.conf
echo 'create cifs.spnego * * /usr/sbin/cifs.upcall -c %k' >> /etc/request-key.conf
echo 'create dns_resolver * * /usr/sbin/cifs.upcall %k' >> /etc/request-key.conf
