#!/usr/bin/env bash

# Add the current accounts to /etc/passwd.
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/passwd >> /etc/passwd

# Add the configured passwords for these accounts to /etc/shadow.
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/shadow >> /etc/shadow
