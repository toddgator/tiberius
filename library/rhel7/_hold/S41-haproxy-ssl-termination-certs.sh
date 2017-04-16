#!/bin/bash
  cat /etc/httpd/certs/thig.com.key /etc/httpd/certs/thig.com.crt /etc/httpd/certs/gd_bundle.crt > /etc/httpd/certs/thig.com.pem
  cat /etc/httpd/certs/beta.thig.com.key /etc/httpd/certs/beta.thig.com.crt /etc/httpd/certs/gd_bundle.crt > /etc/httpd/certs/beta.thig.com.pem
