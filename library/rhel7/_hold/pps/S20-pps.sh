#!/usr/bin/env bash

# Globals
SRVPRO4ROOT="/srv/pro4"
DATAROOT="${SRVPRO4ROOT}/data"
BOOTSROOT="${SRVPRO4ROOT}/boots"

##
## Adding default pro4 and aurora users
##
echo "Adding pro4 and proiv_aurora users..."
useradd pro4
useradd proiv_aurora
echo "Done."
echo ""

## Importing our typical 'thig-settings' from the SDI
. /etc/sdi/thig-settings

##
## Create the primary PPS data directories
##
DATADIRS="megdata imports exports megprt"
for d in ${DATADIRS}; do
  directory="${DATAROOT}/${d}"

  echo "Creating directory and assigning owner 'pro4/pro4' for '${directory}'..."
  mkdir -p ${directory}
  chown pro4:pro4 ${directory}
  echo "Done."
done


##
## Create primary boots directory and simulate alternatively named directories
##
mkdir -p /srv/pro4/boots/secure
mkdir -p /srv/pro4/boots/${ENVIRONMENT}
ALT_ENVIRONMENT_NAMES="dev prod qa"
for d in ${ALT_ENVIRONMENT_NAMES}; do
  cd ${BOOTSROOT}
  echo "Creating symlink named ${d} to ${ENVIRONMENT} boots directory..."
  ln -s ${ENVIRONMENT} ${d}
  echo "Done."
  cd -
done

## Create a generic logs directory
mkdir -p ${SRVPRO4ROOT}/logs
chown pro4:pro4 ${SRVPRO4ROOT}/logs

## Configure file-max system setting
echo "fs.file-max=6553600" >> /etc/sysctl.conf
sysctl -p

## Install extra packages needed for ProIV installer
yum -y install unixODBC unixODBC-devel libaio-devel

## Set pro4 owner:group for everything under /srv/pro4
chown -R pro4:pro4 ${SRVPRO4ROOT}

## Automatically install the latest version of PPS
wget -q http://thirdparty.thig.com/pro4/PROIV_7.1.53.4_Linux_x86-64.bin -O /opt/PROIV_7.1.53.4_Linux_x86-64.bin
chmod +x /opt/PROIV_7.1.53.4_Linux_x86-64.bin

cat << \EOF >> /tmp/expected_install_pro4.sh
#!/bin/bash
expect -c "
set timeout 40
spawn /opt/PROIV_7.1.53.4_Linux_x86-64.bin -console
expect \" 5 to Redisplay \"
send \"1\r\"
expect \"Type q to quit\"
send \"q\r\"
expect \"en you are finished: \"
send \"1\r\"
expect \"en you are finished: \"
send \"0\r\"
expect \"or 5 to Redisplay \"
send \"1\r\"
expect \"northgatearinso/proiv_version_7\"
send \"/opt/pro4/v7.1.53.4\r\"
expect \"or 5 to Redisplay \"
send \"1\r\"
# Select the features for PROIV Version 7.1 you would like to install: 
expect \" Enter command \"
# Remove Aurora
send \"9\r\"
expect \" Enter command \"
# Remove Open Client
send \"8\r\"
expect \"Enter command \"
# Remove Active Web
send \"2\r\"
expect \"Enter command \"
send \"0\r\"
expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Licence Server - InstallShield Wizard
#   IMPORTANT NOTE!! --> Despite the fact that we use a specific server for
#   licensing throughout all of our dev/qa environments the licenceServer must
#   be installed locally in order for the vmConfigurator service to work
#   initially. DO NOT ATTEMPT TO REMOVE THIS FROM THE DEFAULT INSTALLATION
#   SCRIPTS!! You will be in for quite a headache while trying to figure out
#   why the control panel won't work properly post-install.

expect \"HTTP Port: \"
send \"\r\"

expect \"PROIV Licence Server\"
send \"\r\"

expect \"Enable Statistics Logging: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

expect \"Press Enter\"
send \"\r\"

expect \"Import Licence File: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Active Web - InstallShield Wizard
#
#expect \"HTTP Port: \"
#send \"\r\"
#
#expect \"Script Debugging: \"
#send \"\r\"
#
#expect \"Script Debugger Port: \"
#send \"\r\"
#
#expect \"automatic start/stop of daemon: \"
#send \"\r\"
#
#expect \"or 5 to Redisplay \"
#send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Web Services - InstallShield Wizard


expect \"HTTP Port: \"
send \"\r\"

expect \"Application Name \"
send \"\r\"

expect \"Enable Statistics Logging: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Statistics - InstallShield Wizard

expect \"HTTP Port: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

expect \"Press Enter\"
send \"\r\"

expect \"the options above: \"
send \"1\r\"

expect \"Hostname: \"
send \"oracle.ENVIRONMENTURL-SED.thig.com\r\"

expect \"Database Port: \"
send \"\r\"

expect \"Database Name: \"
send \"DBNAME-SED\r\"

expect \"Database Username:\"
send \"DBUSERNAME-SED\r\"

expect \"Database Password:\"
send \"DBPASSWORD-SED\r\"

expect \"test the connection settings?\"
send \"N\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#  PROIV Gateway - InstallShield Wizard

expect \"HTTP Port: \"
send \"\r\"

expect \"Application Name \"
send \"\r\"

expect \"Enable Statistics Logging: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Control Panel - InstallShield Wizard


expect \"HTTP Port: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Virtual Machine - InstallShield Wizard

expect \"Enter command \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#PROIV Virtual Machine - InstallShield Wizard
#
#   PROIV Environment Selection

expect \"environment from the options above: \"
send \"1\r\"

expect \"ISIN selected environment? \"
send \"N\r\"

expect \" ISIN demonstration files? \"
send \"N\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

expect \"Press Enter\"
send \"\r\"

#   PROIV Virtual Machine - InstallShield Wizard
#
#   Lexicon Database Connection Configuration

expect \"Enter one of the options above: \"
send \"\r\"
    
expect \"Hostname: \"
send \"oracle.ENVIRONMENTURL-SED.thig.com\r\"

expect \"Database Port: \"
send \"\r\"

expect \"atabase Name: \"
send \"DBNAME-SED\r\"

expect \"Database Username:\"
send \"DBUSERNAME-SED\r\"

expect \"Database Password:\"
send \"DBPASSWORD-SED\r\"

expect \"test the connection settings?\"
send \"N\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#  PROIV Virtual Machine - InstallShield Wizard
expect \"Default filetype: \"
send \"1\r\"

expect \"Username:\"
send \"DBUSERNAME-SED\r\"

expect \"Password:\"
send \"DBPASSWORD-SED\r\"

expect \"Database Name:\"
send \"DBNAME-SED\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"


#-------------------------------------------------------------------------------
#   PROIV Virtual Machine Configurator - InstallShield Wizard

expect \"HTTP Port: \"
send \"\r\"

expect \"automatic start/stop of daemon: \"
send \"\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

#-------------------------------------------------------------------------------
#   PROIV Version 7.1 - InstallShield Wizard

expect \"Admin username: \"
send \"\r\"

expect \"Admin password:\"
send \"admin\r\"

expect \"Verify password:\"
send \"admin\r\"

expect \"or 5 to Redisplay \"
send \"1\r\"

# Installation Summary

expect \"or 5 to Redisplay \"
send \"1\r\"

expect \"5 to Redisplay 3\"
send \"1\r\"

expect eof
"
EOF

chmod +x /tmp/expected_install_pro4.sh
. /etc/sdi/thig-settings
sed -i "s/DBNAME-SED/${DBNAME}/g"  /tmp/expected_install_pro4.sh
sed -i "s/DBUSERNAME-SED/proddev/g"  /tmp/expected_install_pro4.sh
sed -i "s/DBPASSWORD-SED/hill98tower/g"  /tmp/expected_install_pro4.sh
sed -i "s/ENVIRONMENTURL-SED/${ENVIRONMENT}/g"  /tmp/expected_install_pro4.sh

cd /tmp
./expected_install_pro4.sh
ln -s /opt/pro4/v7.1.53.4/ /opt/pro4/current

##
## Create init.d script symlinks
##
INITSCRIPTS="/opt/sdi/sdi_service_scripts/init/sdi.pps\
              /opt/pro4/v7.1.53.4/control_panel/bin/controlPanel\
              /opt/pro4/v7.1.53.4/gateway/bin/gateway\
              /opt/pro4/v7.1.53.4/statistics/bin/statistics\
              /opt/pro4/v7.1.53.4/virtual_machine/bin/vmConfigurator\
              /opt/pro4/v7.1.53.4/web_services/bin/webServices"
for script in ${INITSCRIPTS}; do
  cd /etc/init.d
  ln -s ${script}
  cd -
done

##
## Add sdi.pps service to chkconfig configuration and enable it for run-levels
##
chkconfig --add sdi.pps # Adding sdi.pps to chkconfig control
chkconfig sdi.pps on    # enabling pps service for runlevels 2,3,4, and 5

##
## Remove the symlink for the licenceServer startup script
##
if [[ -L /etc/init.d/licenceServer || -f /etc/init.d/licenceServer ]]; then
  rm -f /etc/init.d/licenceServer
fi