#!/bin/bash
#
# From: http://tailon.readthedocs.io/en/latest/
# 
# Requires Python v2.7 or above and can be installed from dev from github.
. /etc/sdi/thig-settings

yum -y install python-pip
pip install --upgrade pip
pip install PyYAML==3.11
pip install git+git://github.com/gvalkov/tailon.git
ln -sf /opt/sdi/thig-application-configs-global/applications/tailon/tailon.yaml /etc/tailon.yaml
cd /etc/systemd/system/
ln -s /opt/sdi/sdi_service_scripts/init/tailon.service
cd /etc/systemd/system/multi-user.target.wants/
ln -s /opt/sdi/sdi_service_scripts/init/tailon.service
