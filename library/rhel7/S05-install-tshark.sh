#!/bin/bash
#
# Installs the 'wireshark' package.

# tshark -o "ssl.desegment_ssl_records: TRUE" -o "ssl.desegment_ssl_application_data: TRUE" -o "ssl.keys_list:10.1.18.135,443,http,/etc/httpd/certs/uat.thig.com.key" -o "ssl.debug_file:ssldebug.log" -f "tcp port 443" -R "ssl" -V -x | grep -i chines
yum -y install wireshark
