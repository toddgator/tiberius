#!/bin/bash
sed -i "s|Subsystem.*sftp.*usr/libexec.*||g" /etc/ssh/sshd_config
echo "Subsystem       sftp    /usr/libexec/openssh/sftp-server -f AUTH -l INFO" >> /etc/ssh/sshd_config
