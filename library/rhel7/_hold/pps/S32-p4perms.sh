#!/usr/bin/env bash


. /etc/sdi/thig-settings

##
## Setting permissions for virtual machine logs and '/srv/pro4/logs' files
##
JVMLOGDIR="/opt/pro4/current/virtual_machine/logs"

for log in jvmerr.log jvmout.log; do
  LOG_FPATH="${JVMLOGDIR}/${log}"
  echo "Touching and setting ACLs for ${LOG_FPATH}..."
  touch ${LOG_FPATH}
  setfacl -m g:'domain users':rwx ${LOG_FPATH}
  echo "Done."
  echo ""
done

SRVPRO4_LOGS_DIR="/srv/pro4/logs"
touch ${SRVPRO4_LOGS_DIR}/proivlog.txt
chown pro4:'domain users' ${SRVPRO4_LOGS_DIR}/proivlog.txt
setfacl -Rm g:'domain users':rwx ${SRVPRO4_LOGS_DIR}
setfacl -dm g:'domain users':rwx ${SRVPRO4_LOGS_DIR}


##
## Setting ACL and default ACL for symlinks under '/'
##
cd /
ROOTDIRLIST="catletters ClaimAckLetters cms_xlcomp cms_xlrout desinkletters stat\
 FNOL FNOLTEMP iso Nationwide NoResponseLetters PayReminderLetters\
 PastDueLetters s10dletters"

for dir in ${ROOTDIRLIST} "/srv/pro4/data/megdata/eliens"; do
  cd ${dir}
  echo "Setting ACL and default ACL for ${dir}..."
  find . -type d -exec setfacl -dm g:'domain users':rwx {} \;
  find . -type d -exec setfacl -m g:'domain users':rwx {} \;
  find . -type f -exec setfacl -m g:'domain users':rwx {} \;
  echo "Done."
  cd -
done


##
## Setting ACL and default ACL for '/srv/pro4/data' directories
##
setfacl -dm g:'domain users':rwx /srv/pro4/data  # default ACL for root 'data' directory

cd /srv/pro4/data
SRVPRO4DATADIRLIST="exports imports megdata megprt"

for d in ${SRVPRO4DATADIRLIST}; do
  echo "Setting ACL and default ACL for ${d}..."
  find ./${d} -type d -exec setfacl -dm g:'domain users':rwx {} \;
  find ./${d} -type d -exec setfacl -m g:'domain users':rwx {} \;
  find ./${d} -type f -exec setfacl -m g:'domain users':rwx {} \;
  echo "Done."
  echo ""
done

##
## Setting ACL for files in '/srv/pro4/boots/${environment}' and '/srv/pro4/boots/secure' directories
##
BOOTS="/srv/pro4/boots/${ENVIRONMENT}"
BOOTSSECURE="/srv/pro4/boots/secure"
setfacl -dm g:'domain users':rwx ${BOOTS}
setfacl -dm g:'domain users':rwx ${BOOTSSECURE}
find ${BOOTS} -type f -exec setfacl -m g:'domain users':rwx {} \;
find ${BOOTSSECURE} -type f -exec setfacl -m g:'domain users':rwx {} \;
