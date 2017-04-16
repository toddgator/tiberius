#!/bin/bash
VERSION=1.0.0

. /etc/sdi/thig-settings
shopt -s nullglob

BASEDIR=/opt/sdi/thig-application-configs-global

##
# Populate /etc/credentials
##
mkdir -p /etc/credentials
mkdir -p /etc/credentials/keystores

for credfile in ${BASEDIR}/roles/${ROLE}/all/*.credfile ${BASEDIR}/roles/${ROLE}/${ENVIRONMENT}/*.credfile
do
    cp -p $credfile /etc/credentials
done

for keystore in ${BASEDIR}/roles/${ROLE}/all/*.keystore ${BASEDIR}/roles/${ROLE}/${ENVIRONMENT}/*.keystore
do
    cp -p $keystore /etc/credentials/keystores
done
