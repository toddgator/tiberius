#!/bin/bash

export OPENDJ_JAVA_HOME=/opt/java

cd /opt/forgerock/sources/ldif

# THIG Specific Variables
. /etc/sdi/thig-settings

# OpenDJ Specific Variables
CURDIR=`pwd`                                      # Current Folder
INSTALLDIR="/opt/forgerock"                       # Folder where the DJ instance will be installed
DJDIR="$INSTALLDIR/opendj"                        # OpenDJ Folder
ODJSOFT="/opt/forgerock/sources/opendj/opendj-latest-2017.zip"      
ODJFQDN=`hostname`                                # OpenDJ Fully Qualified Host Name
ROOTDN="cn=THIG Admin"                            # OpenDJ Administration User
ROOTPASS="cangetin"                               # OpenDJ Admin User's Password
LDAPPORT="389"                                    # LDAP Port on DJ Store
ADMINPORT="4444"                                  # ADMIN Port on DJ Store
BASEDN="dc=thig,dc=com"                           # Root Suffix for DJ Store

echo ""
echo "###############################"
echo "# DJ: INSTALLATION INITIATED! #"
echo "###############################"

echo ""
echo "#####################################"
echo "# DJ: Extracting OpenDJ instance... #"
echo "#####################################"
unzip $ODJSOFT -d $INSTALLDIR

echo ""
echo "#####################################"
echo "# DJ: Installing OpenDJ Instance... #"
echo "#####################################"
$DJDIR/setup --cli --no-prompt --rootUserDN "$ROOTDN" --rootUserPassword "$ROOTPASS" --hostname $ODJFQDN --ldapPort $LDAPPORT --adminConnectorPort $ADMINPORT --baseDN "$BASEDN" --addBaseEntry --doNotStart --acceptLicense


