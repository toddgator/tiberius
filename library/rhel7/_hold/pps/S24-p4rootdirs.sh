#!/usr/bin/env bash

. /etc/sdi/thig-settings

#
# GLOBALS
#
SRVROOT="/srv/pro4"
USRPRO4ROOT="/usr/pro4"
PRO4DATAROOT="${SRVROOT}/data"
PRO4BOOTSROOT="${SRVROOT}/boots"
MEGDATA="${PRO4DATAROOT}/megdata"


#
# Method creates a link in 'link_destination' ($1) to 'link_target' ($2)
#
create_symlink () {
  local link_destination=$1
  local link_target=$2

  echo "Creating symlink in '${link_destination}' to '${link_target}'..."
  cd ${link_destination}
  ln -s ${link_target}
  cd -
  echo "Done."
  echo ""
}

#
# Method creates directory and then sets permissions/ACL's
#
mkdir_and_set_perms () {
  local directory=$1
   
  echo "Creating and setting permissions for '${directory}'..."
  mkdir -p ${directory}
  chown pro4:pro4 ${directory}
  setfacl -m g:'domain users':rwx ${directory}
  setfacl -dm g:'domain users':rwx ${directory}
  echo "Done."
  echo ""
}


##
## Making sure the sernet-samba-winbindd service is up in order for the setfacl
## utility to recognize the 'domain users' group.
##
/sbin/service sernet-samba-winbindd restart
sleep 10


##
## Adding template megdata data files and template boots files
##
cd /tmp
wget http://sflgnvlms01.thig.com/inhouse/pro4/baseline/baseline-megdata.tgz
tar -xvzf /tmp/baseline-megdata.tgz -C ${MEGDATA}
wget http://sflgnvlms01.thig.com/inhouse/pro4/baseline/baseline-boots.tgz
tar -xvzf /tmp/baseline-boots.tgz -C ${PRO4BOOTSROOT}/${ENVIRONMENT}
wget http://sflgnvlms01.thig.com/inhouse/pro4/baseline/baseline-secure.tgz
tar -xvzf /tmp/baseline-secure.tgz -C ${PRO4BOOTSROOT}/secure
find ${MEGDATA} -type f -exec chown pro4:pro4 {} \;
find ${PRO4BOOTSROOT}/${ENVIRONMENT} -type f -exec chown pro4:pro4 {} \;
find ${PRO4BOOTSROOT}/secure -type f -exec chown pro4:pro4 {} \;
cd -


##
## Create 'docs' directory and it's respective subdirectories
##
DOCSROOT="${MEGDATA}/docs"
mkdir_and_set_perms ${DOCSROOT}              # root 'docs' directory
cd /
ln -s ${DOCSROOT}
cd -

DOCS_SUBDIRS="apel canc canr cann ccnr catt clak dsnk einv enot fnol ernv iinv\
 noel nonr nren norl nwrm pdue rein psdl renr rinv xpir xpre"

for d in ${DOCS_SUBDIRS}; do
  directory="${DOCSROOT}/${d}"
  mkdir_and_set_perms ${directory}           # subdirectories of 'docs'
#  create_symlink "/" ${directory}
done

MEGDATA_DOCS_DIRS="catletters ClaimAckLetters cms_xlcomp cms_xlrout\
 desinkletters stat FNOL FNOLTEMP iso Nationwide NoResponseLetters\
 PayReminderLetters PastDueLetters s10dletters"

for d in ${MEGDATA_DOCS_DIRS}; do           # doc directries in data/megdata
  directory="${MEGDATA}/${d}"
  mkdir_and_set_perms ${directory}
  create_symlink "/" ${directory}

  # Group of dirs that require an 'archive' sub-directory be created
  if [[ $d =~ "catletters" ]] || [[ $d =~ "ClaimAckLetters" ]] || \
      [[ $d =~ "desinkletters" ]] || [[ $d =~ "FNOL" ]] || \
      [[ $d =~ "Nationwide" ]] || [[ $d =~ "PastDueLetters" ]] || \
      [[ $d =~ "s10dletters" ]]; then
    mkdir_and_set_perms "${directory}/archive"
  fi
done


##
## Create some other various megdata output directories
##
OTHER_MEGDATA_DIRS="attachments automatedclearinghouse backup backupcheckfiles\
 checkfiles CNSLLINK DUTF ftp ftpcheckfiles HUTF stat tmp UTV voidcheckfiles"

FTP_SUBDIRECTORIES="accountingstatus clearedcheck clearedcheckarchive\
 clearedclmchecksboa clearedclmchecksboaarchive clearedclmcheckspnc\
 clearedclmcheckspncarchive clearedclmcheckswfg clearedclmcheckswfgarchive\
 fslso fslsoarchive pgpArchive"

for d in ${OTHER_MEGDATA_DIRS}; do
  directory="${MEGDATA}/${d}"
  mkdir_and_set_perms ${directory}

  # 'ftp' dir has a number of subdirectories required
  if [[ $d =~ "ftp" ]]; then
    for dd in ${FTP_SUBDIRECTORIES}; do
      mkdir_and_set_perms "${directory}/${dd}"
    done
  fi
done

# Create '/' symlink for ${MEGDATA}/stat directory
ln -s ${MEGDATA}/stat /comstats


##
## Creating some /srv/pro4 directories
##
SRV_PRO4_DIRS="AP_checks cmschecks scripts data/megdata/eliens/processed"

for d in ${SRV_PRO4_DIRS}; do
  directory="${SRVROOT}/${d}"
  mkdir_and_set_perms ${directory}
done

chown -R pro4:pro4 ${SRVROOT}/data/megdata/eliens
cd ${SRVROOT}/data/megdata/
find ./eliens -type d -exec setfacl -dm g:'domain users':rwx {} \;
find ./eliens -type f -exec setfacl -m g:'domain users':rwx {} \;


##
## /usr/pro4 emulation
##
mkdir -p ${USRPRO4ROOT}
chown pro4:pro4 ${USRPRO4ROOT}

OPT_PRO4_INSTALL_ROOT="/opt/pro4/v7.1.53.4"
echo "Creating symlink for '${OPT_PRO4_INSTALL_ROOT}' as ${USRPRO4ROOT}/current..."
ln -s ${OPT_PRO4_INSTALL_ROOT} ${USRPRO4ROOT}/current
echo "Done."
echo ""
create_symlink ${USRPRO4ROOT} ${OPT_PRO4_INSTALL_ROOT}

SRV_PRO4_DIRS="AP_checks boots cmschecks data logs scripts"

for d in ${SRV_PRO4_DIRS}; do
  directory="${SRVROOT}/${d}"
  if [ -d ${directory} ]; then
    create_symlink ${USRPRO4ROOT} ${directory}
  fi
done


##
## Setting '/srv/pro4/data' subdirectory permissions
##
DIRS="exports imports megdata megprt"

for d in ${DIRS}; do
  directory="${PRO4DATAROOT}/${d}"
  echo "Setting system permissions and ACL for ${directory}..."
  setfacl -Rdm g:'domain users':rwx ${directory}
  setfacl -Rm g:'domain users':rwx ${directory}
  echo "Done."
  echo ""
done


##
## Creating symlinks for all the files in '/srv/pro4/boots/secure' in '/srv/pro4/boots/${ENVIRONMENT}'
##
SECURE="/srv/pro4/boots/secure"
BOOTS="/srv/pro4/boots/${ENVIRONMENT}"
cd ${SECURE}
for fd in $(ls); do
  create_symlink ${BOOTS} ${SECURE}/${fd}
done
cd -