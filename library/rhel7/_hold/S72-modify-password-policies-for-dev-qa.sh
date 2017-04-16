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

#Modify Default Password Policy (after loading users and setting their roles, permissions and passwords)
/opt/forgerock/opendj/bin/dsconfig set-password-policy-prop --port 4444 --hostname localhost --bindDN "cn=thig admin" --bindPassword cangetin --policy-name "Default Password Policy" --set password-history-count:0 --set force-change-on-add:true --set force-change-on-reset:true --set allow-expired-password-changes:true --set allow-user-password-changes:true --set grace-login-count:1 --set last-login-time-attribute:ds-pwp-last-login-time --set last-login-time-format:"yyyyMMddHHmmss'Z'" --set previous-last-login-time-format:"yyyyMMddHHmmss'Z'" --set lockout-failure-count:5 --set max-password-age:200d --set idle-lockout-interval:200d --set password-attribute:userpassword --set password-expiration-warning-interval:5d --add password-validator:"Character Set" --add password-validator:"Length-Based Password Validator" --trustAll --no-prompt

