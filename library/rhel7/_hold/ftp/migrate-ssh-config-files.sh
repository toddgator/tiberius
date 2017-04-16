#!/usr/bin/env bash


# 'eftlockbox' user
mkdir -v /home/eftlockbox/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.eftlockbox > /home/eftlockbox/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.eft_admin > /home/eftlockbox/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.eftlockbox > /home/eftlockbox/.ssh/authorized_keys
chown -vR eftlockbox:eftlockbox /home/eftlockbox/.ssh
chmod -v 600 /home/eftlockbox/.ssh/*

# 'innov_admin' user
mkdir -v /home/innov_admin/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.innov_admin > /home/innov_admin/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.innov_admin > /home/innov_admin/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.innov_admin > /home/innov_admin/.ssh/authorized_keys
chown -vR innov_admin:innov_admin /home/innov_admin/.ssh
chmod -v 600 /home/innov_admin/.ssh/*

# 'ivantage' user
mkdir -v /home/ivantage/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.ivantage > /home/ivantage/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.ivantage > /home/ivantage/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.ivantage > /home/ivantage/.ssh/authorized_keys
chown -vR ivantage:ivantage /home/ivantage/.ssh
chmod -v 600 /home/ivantage/.ssh/*

# 'pentaho' user
mkdir -v /home/pentaho/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pentaho > /home/pentaho/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.pentaho > /home/pentaho/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.pentaho > /home/pentaho/.ssh/authorized_keys
chown -vR pentaho:pentaho /home/pentaho/.ssh
chmod -v 600 /home/pentaho/.ssh/*

# 'ppsadmin' user
mkdir -v /home/ppsadmin/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.ppsadmin > /home/ppsadmin/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.ppsadmin > /home/ppsadmin/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.ppsadmin > /home/ppsadmin/.ssh/authorized_keys
chown -vR ppsadmin:ppsadmin /home/ppsadmin/.ssh
chmod -v 600 /home/ppsadmin/.ssh/*

# 'svc_latitude' user
mkdir -v /home/svc_latitude/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.svc_latitude > /home/svc_latitude/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.svc_latitude > /home/svc_latitude/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.svc_latitude > /home/svc_latitude/.ssh/authorized_keys
chown -vR svc_latitude:svc_latitude /home/svc_latitude/.ssh
chmod -v 600 /home/svc_latitude/.ssh/*

# Recreate the .ssh configuration files for the 'wellsfargo' user.
mkdir -v /home/wellsfargo/.ssh
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.wellsfargo > /home/wellsfargo/.ssh/id_rsa
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/id_rsa.pub.wellsfargo > /home/wellsfargo/.ssh/id_rsa.pub
cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/ftp/prod/ssh/authorized_keys.wellsfargo > /home/wellsfargo/.ssh/authorized_keys
chown -vR wellsfargo:wellsfargo /home/wellsfargo/.ssh
chmod -v 600 /home/wellsfargo/.ssh/*
