#!/bin/bash
useradd opendj -g forgerock -d /opt/forgerock/opendj
cd /opt/forgerock
mkdir backup
chown -R opendj:forgerock backup
cd /tmp
wget "http://thirdparty.thig.com/forgerock/opendj-latest.zip"
