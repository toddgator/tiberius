#!/bin/bash
yum -y install httpd openssl mod_ssl mod_php

chkconfig httpd on --level 3
