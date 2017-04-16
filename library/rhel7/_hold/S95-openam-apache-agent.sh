#!/bin/bash
cd /opt
wget http://thirdparty.thig.com/forgerock/apache-web-agent-x64-latest.zip
unzip apache-web-agent-x64-latest.zip
rm -f apache-web-agent-x64-latest.zip
service httpd stop
echo 'Slowstory28!' >>  /opt/web_agents/apache24_agent/config/pa.dat

mkdir -p /var/log/forgerock/webagent/logs
grep "/var/log/forgerock/webagent/logs" /etc/fstab || echo "/opt/web_agents/apache24_agent/instances/agent_1/logs/              /var/log/forgerock/webagent/logs          bind    defaults,bind   0 0" >> /etc/fstab


chmod 400 /opt/web_agents/apache24_agent/config/pa.dat
cd /opt/web_agents/apache24_agent/bin
. /etc/sdi/thig-settings

hostname | grep 10 || ./agentadmin --s "/etc/httpd/conf/httpd.conf" "https://auth${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com:443/auth" "https://innovation${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com:443" "/thig" "innovationverify$(hostname -s | cut -c11)${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com" '/opt/web_agents/apache24_agent/config/pa.dat' --changeOwner --acceptLicence

hostname | grep 10 && ./agentadmin --s "/etc/httpd/conf/httpd.conf" "https://auth${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com:443/auth" "https://innovation${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com:443" "/thig" "innovationverify$(hostname -s | cut -c10-11)${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com" '/opt/web_agents/apache24_agent/config/pa.dat' --changeOwner --acceptLicence

chown -R apache:apache /opt/web_agents
# Remove config for turning on agent based on OpenAM WebAgent configuration file, this was moved to the innovation_hosts.conf 
sed -i "s/AmAgent.*//g" /etc/httpd/conf/httpd.conf
# Turn on debug logging, remember that the logs for the apache agent do not start until a request hits the vhost container that containes the AmAgent On directive.
sed -i "s/com.sun.identity.agents.config.debug.level = error/com.sun.identity.agents.config.debug.level = debug/g" /opt/web_agents/apache24_agent/instances/agent_1/config/agent.conf 
