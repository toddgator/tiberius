#!/bin/bash

export OPENDJ_JAVA_HOME=/opt/java

cd /opt/forgerock/scripts/opendj

# THIG Specific Variables
. /etc/sdi/thig-settings

# OpenDJ Specific Variables
CURDIR=`pwd`                                      # Current Folder
INSTALLDIR="/opt/forgerock"                       # Folder where the DJ instance will be installed
DJDIR="$INSTALLDIR/opendj"                        # OpenDJ Folder
BINDIR="$DJDIR/bin"                               # Folder where OpenDJ binaries are installed
ODJSOFT="/tmp/opendj-latest.zip"      
ODJFQDN=`hostname`                                # OpenDJ Fully Qualified Host Name
ROOTDN="cn=THIG Admin"                            # OpenDJ Administration User
ROOTPASS="cangetin"                               # OpenDJ Admin User's Password
LDAPPORT="1389"                                   # LDAP Port on DJ Store
ADMINPORT="4444"                                  # ADMIN Port on DJ Store
BASEDN="dc=thig,dc=com"                           # Root Suffix for DJ Store
ARTIFACTS="$CURDIR/artifacts"                     # Folder containing customization files
JAVAPROP="$ARTIFACTS/java.properties"             # DJ extended schema (Company)
DJSCHEMA="$ARTIFACTS/thigSchema.ldif"             # DJ extended schema (Company)
AMSCHEMA="$ARTIFACTS/amSchema.ldif"               # DJ extended schema (OpenAM)
LDIF="$ARTIFACTS/thigData.ldif"                   # DJ DIT Structure
INDICES="$ARTIFACTS/thigIndices.ldif"             # DJ Indices
POLICIES="$ARTIFACTS/thigPolicies.ldif"           # DJ Password Policies 
GLOBALACI="$ARTIFACTS/globalACI.ldif"             # DJ Global ACIs

echo ""
echo "###############################"
echo "# DJ: INSTALLATION INITIATED! #"
echo "###############################"

echo ""
echo "#####################################"
echo "# DJ: Extracting OpenDJ instance... #"
echo "#####################################"
unzip $ODJSOFT -d $INSTALLDIR

echo "Apply 201508 FR Patch"
cd /tmp
wget "http://thirdparty.thig.com/forgerock/OpenDJ-2.6.3-201508.zip"
cd /opt/forgerock/opendj
tar cf backout-patch.tar classes
rm -fr classes
unzip /tmp/OpenDJ-2.6.3-201508.zip

cd /opt/forgerock/scripts/opendj


echo ""
echo "#####################################"
echo "# DJ: Installing OpenDJ Instance... #"
echo "#####################################"
$DJDIR/setup --cli --no-prompt --rootUserDN "$ROOTDN" --rootUserPassword "$ROOTPASS" --hostname $ODJFQDN --ldapPort $LDAPPORT --adminConnectorPort $ADMINPORT --baseDN "$BASEDN" --addBaseEntry --doNotStart --acceptLicense

if [ -f $JAVAPROP ];
then
  echo ""
  echo "##########################################"
  echo "# DJ: Updating OpenDJ Java Properties... #"
  echo "##########################################"
  unalias cp > /dev/null 2>&1
  cp -f $ARTIFACTS/java.properties $DJDIR/config
  echo ""
  echo "#######################################"
  echo "# DJ: Starting the OpenDJ Instance... #"
  echo "#######################################"
  $BINDIR/start-ds
  $BINDIR/dsjavaproperties
else
  echo ""
  echo "#######################################"
  echo "# DJ: Starting the OpenDJ Instance... #"
  echo "#######################################"
  $BINDIR/start-ds
fi
chown -R opendj:forgerock /opt/forgerock/opendj

##
##
echo "$(hostname)" | grep "2" && exit
##
##
if [ -f $DJSCHEMA ];
then
  echo ""
  echo "########################################"
  echo "# DJ: Extending the OpenDJ Schema...   #"
  echo "########################################"
  $BINDIR/ldapmodify --hostname $ODJFQDN --port $LDAPPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --filename $DJSCHEMA
fi

if [ -f $AMSCHEMA ];
then
  echo ""
  echo "####################################################"
  echo "# DJ: Extending the OpenDJ Schema for OpenAM...    #"
  echo "####################################################"
  $BINDIR/ldapmodify --hostname $ODJFQDN --port $LDAPPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --filename $AMSCHEMA
fi

if [ -f $GLOBALACI ];
then
  echo ""
  echo "##############################"
  echo "# DJ: Updating Globa ACIs... #"
  echo "##############################"
  $BINDIR/ldapmodify --hostname $ODJFQDN --port $LDAPPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --filename $GLOBALACI
fi

if [ -f $POLICIES ];
then
  echo ""
  echo "######################################"
  echo "# DJ: Adding DJ-specific Policies... #"
  echo "######################################"
  $BINDIR/ldapmodify --hostname $ODJFQDN --port $LDAPPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --defaultAdd --filename $POLICIES
fi

if [ -f $LDIF ];
then
  echo ""
  echo "#########################################"
  echo "# DJ: Importing the DJ DIT Structure... #"
  echo "#########################################"
  $BINDIR/import-ldif --bindDN "$ROOTDN" --bindPassword "$ROOTPASS" --hostname $ODJFQDN --port $ADMINPORT --includeBranch "$BASEDN" --backendID userRoot --ldifFile $LDIF --rejectFile /tmp/rejects-`date +"%m-%d-%y-%T"`.ldif --skipFile /tmp/skips-`date +"%m-%d-%y-%T"`.ldif --start 0 --trustAll
fi

if [ -f $INDICES ];
then
  echo ""
  echo "#####################################"
  echo "# DJ: Adding DJ-specific Indices... #"
  echo "#####################################"
  $BINDIR/ldapmodify --hostname $ODJFQDN --port $LDAPPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --defaultAdd --filename $INDICES

#  Add presence index
$BINDIR/dsconfig set-local-db-index-prop --backend-name userRoot  --index-name uid  --add index-type:presence --hostname $ODJFQDN --port $ADMINPORT --bindDN "$ROOTDN" --bindPassword $ROOTPASS --trustAll --no-prompt

  echo ""
  echo "#################################"
  echo "# DJ: Rebuilding the Indexes... #"
  echo "#################################"
  $BINDIR/stop-ds
  $BINDIR/rebuild-index --baseDN $BASEDN --rebuildAll
fi

chown -R opendj:forgerock /opt/forgerock/opendj
