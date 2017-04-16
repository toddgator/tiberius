#!/usr/bin/env bash


# Adding our custom THIG users to the respective vsftpd security lists
cat /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/vsftpd/chroot_list >> /etc/vsftpd/chroot_list
cat /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/vsftpd/user_list >> /etc/vsftpd/user_list
cat /opt/sdi/thig-application-configs-global/roles/${LOCATIONCODE}/${OSANDVERSION}/${ROLE}/prod/vsftpd/ftpusers >> /etc/vsftpd/ftpusers

