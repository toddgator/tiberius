#!/bin/bash
yum -y install vsftpd

# Enable vsftpd service at system startup
systemctl enable vsftpd.service
