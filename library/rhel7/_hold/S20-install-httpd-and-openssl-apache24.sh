#!/bin/bash
yum -y install httpd openssl mod_ssl mod_php mod_ldap mod_security

systemctl enable httpd.service
