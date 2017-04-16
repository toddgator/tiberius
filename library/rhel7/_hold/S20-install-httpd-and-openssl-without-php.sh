#!/bin/bash
yum -y install httpd openssl mod_ssl

chkconfig httpd on --level 3
