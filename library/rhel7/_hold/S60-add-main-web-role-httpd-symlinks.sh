#!/bin/bash
cd /etc/httpd/conf.d/sites-enabled/
ln -s ../sites-available/app-thig-com_hosts.conf
#ln -s ../sites-available/symbility-ws_hosts.conf
ln -s ../sites-available/policy-ws_hosts.conf
ln -s ../sites-available/policy-data-ws_hosts.conf
ln -s ../sites-available/oasis_hosts.conf
ln -s ../sites-available/insuredlogin_hosts.conf
ln -s ../sites-available/chatconfig_hosts.conf
ln -s ../sites-available/www_hosts.conf
ln -s ../sites-available/repairpro_hosts.conf 
ln -s ../sites-available/ivr-ws_hosts.conf
ln -s ../sites-available/portal_hosts.conf
ln -s ../sites-available/tasknotes_hosts.conf
ln -s ../sites-available/innovation_hosts.conf
ln -s ../sites-available/iso-cms-services_hosts.conf
ln -s ../sites-available/le-cms-services_hosts.conf
ln -s ../sites-available/symbility-cms-services_hosts.conf
ln -s ../sites-available/citadel_hosts.conf
