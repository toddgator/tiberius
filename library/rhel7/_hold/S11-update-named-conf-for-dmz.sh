#!/bin/bash
if [[ $(hostname -s) =~ ^(xflgnvweb|xflgnvcfs|xflgnvlab|xflgnvslb|xflgnvftp|bflgnvweb|bflgnvslb|xkylexweb|xkylexcfs|xkylexslb|xkylexftp) ]]
then
  sed -i "s/10.1.1.150; 10.1.1.151; 10.3.1.151; 10.3.1.152;/8.8.8.8; 8.8.4.4;/g" /var/named/chroot/etc/named.conf
fi
