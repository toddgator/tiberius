#!/bin/bash
cat << \OTHERTHANEOF >> /root/runme_before_switching_to_dmz_vlan.sh
#!/bin/bash
cat << EOF > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
# Security hosts
172.29.2.30  nfldmztns01.thig.com nfldmztns01
# DMZ Translations
172.29.2.99  xflgnvftp01.thig.com xflgnvftp01
172.29.2.100 xflgnvslb01.thig.com xflgnvslb01
172.29.2.101 xflgnvslb02.thig.com xflgnvslb02
172.29.2.1   xflgnvweb01.thig.com xflgnvweb01
172.29.2.2   xflgnvweb02.thig.com xflgnvweb02
172.29.2.3   xflgnvweb03.thig.com xflgnvweb03
172.29.2.4   xflgnvweb04.thig.com xflgnvweb04
172.29.2.5   xflgnvweb05.thig.com xflgnvweb05
172.29.2.6   xflgnvweb06.thig.com xflgnvweb06
172.29.2.7   xflgnvweb07.thig.com xflgnvweb07
172.29.2.8   xflgnvweb08.thig.com xflgnvweb08
172.29.2.9   xflgnvweb09.thig.com xflgnvweb09
172.29.2.10  xflgnvweb10.thig.com xflgnvweb10
172.29.2.11  bflgnvweb01.thig.com bflgnvweb01
172.29.2.12  bflgnvweb02.thig.com bflgnvweb02
172.29.2.13  xflgnvcfs01.thig.com xflgnvcfs01
172.29.2.14  xflgnvcfs02.thig.com xflgnvcfs02
172.29.2.20  bflgnvslb01.thig.com bflgnvslb01
172.29.2.23  bflgnvslb03.thig.com bflgnvslb03
172.29.2.24  bflgnvslb04.thig.com bflgnvslb04
172.29.2.25  bflgnvslb05.thig.com bflgnvslb05

# Inside Translations
10.1.0.2     nflgnvtnm01.thig.com nflgnvtnm01
10.1.1.24    sflgnvwab01.thig.com sflgnvwab01
10.1.1.29    sflgnvwab02.thig.com sflgnvwab02
10.1.1.34    sflgnvwab03.thig.com sflgnvwab03
10.1.1.12    sflgnvwab04.thig.com sflgnvwab04
10.1.1.73    sflgnvwab05.thig.com sflgnvwab05
10.1.21.1    sflgnvrpm01.thig.com sflgnvrpm01
10.1.21.2    sflgnvrpm02.thig.com sflgnvrpm02
10.1.21.3    sflgnvrpm03.thig.com sflgnvrpm03
10.1.21.4    sflgnvrpm04.thig.com sflgnvrpm04
10.1.21.5    sflgnvrpm05.thig.com sflgnvrpm05
10.1.21.6    sflgnvrpm06.thig.com sflgnvrpm06
10.1.21.7    sflgnvrpm07.thig.com sflgnvrpm07
10.1.21.8    sflgnvrpm08.thig.com sflgnvrpm08
10.1.21.9    sflgnvrpm09.thig.com sflgnvrpm09
10.1.21.10   sflgnvrpm10.thig.com sflgnvrpm10
10.1.1.191   sflgnvinv01.thig.com sflgnvinv01
10.1.1.70    sflgnvinv02.thig.com sflgnvinv02
10.1.1.86    sflgnvinv03.thig.com sflgnvinv03
10.1.1.192   sflgnvinv04.thig.com sflgnvinv04
10.1.1.193   sflgnvinv05.thig.com sflgnvinv05
10.1.21.101  bflgnvrpm01.thig.com bflgnvrpm01
10.1.21.102  bflgnvrpm02.thig.com bflgnvrpm02
10.1.1.10    bflgnvwab01.thig.com bflgnvwab01
10.1.1.41    bflgnvwab02.thig.com bflgnvwab02
10.1.1.220   bflgnvodj01.thig.com bflgnvodj01
10.1.1.221   bflgnvoam01.thig.com bflgnvoam01
10.1.15.52   github.thig.com      sflgnvghb02
10.1.15.40   sflgnvcfs02.thig.com sflgnvcfs02
10.1.1.118   sflgnvlms01.thig.com sflgnvlms01
10.1.1.196   bflgnvinv01.thig.com bflgnvinv01
10.1.1.197   bflgnvinv02.thig.com bflgnvinv02
10.1.1.191   sflgnvinv01.thig.com sflgnvinv01
10.1.1.70    sflgnvinv02.thig.com sflgnvinv02
10.1.1.86    sflgnvinv03.thig.com sflgnvinv03
10.1.1.192   sflgnvinv04.thig.com sflgnvinv04
10.1.1.193   sflgnvinv05.thig.com sflgnvinv05
10.1.21.21   bflgnvcit01.thig.com bflgnvcit01
10.1.21.22   bflgnvcit01.thig.com bflgnvcit01
10.1.21.23   bflgnvcit01.thig.com bflgnvcit01
10.1.21.24   bflgnvcit01.thig.com bflgnvcit01
10.1.21.25   bflgnvcit01.thig.com bflgnvcit01


# Farm/VIP Translations
172.29.2.200 oasis.thig.com
172.29.2.200 oasisinside.thig.com
172.29.2.230 insuredlogin.thig.com
172.29.2.210 innovation.thig.com
172.29.2.110 www.thig.com
172.29.2.215 symbility-ws.thig.com
172.29.2.140 policy-ws.thig.com
172.29.2.155 app.thig.com
172.29.2.195 chatconfig.thig.com
172.29.2.170 oasis.beta.thig.com
172.29.2.70  insuredlogin.beta.thig.com
172.29.2.85  innovation.beta.thig.com
172.29.2.115 www.beta.thig.com
172.29.2.205 symbility-ws.beta.thig.com
172.29.2.150 policy-ws.beta.thig.com
172.29.2.165 app.beta.thig.com
172.29.2.65  chatconfig.beta.thig.com
172.29.2.120 auth.beta.thig.com
172.29.2.125 identity.beta.thig.com
172.29.2.130 auth.thig.com
172.29.2.135 identity.thig.com
172.29.2.251 haproxy.thig.com
172.29.2.252 haproxy.beta.thig.com
172.29.2.160 ivr-ws.thig.com
172.29.2.190 ivr-ws.beta.thig.com
172.29.2.212 portal.thig.com
172.29.2.112 portal.beta.thig.com
172.29.2.192 policy-data-ws.beta.thig.com
172.29.2.202 policy-data-ws.thig.com
172.29.2.203 citadel.thig.com
172.29.2.204 citadel.beta.thig.com
EOF

sed -i "s/dhcp/static/g" /etc/sysconfig/network-scripts/ifcfg-eth0
echo "GATEWAY=172.29.2.254" >> /etc/sysconfig/network-scripts/ifcfg-eth0
echo "NETMASK=255.255.255.0" >> /etc/sysconfig/network-scripts/ifcfg-eth0
IP="$(grep -i "$(hostname -s)" /etc/hosts|awk '{print $1}')"
echo "IPADDR=$IP" >> /etc/sysconfig/network-scripts/ifcfg-eth0

cd /etc/cron.d
rm -f syncNTPToDomainController.cron
rm -f update-java-certs.cron

rm -f /usr/lib/check_mk_agent/local/600/winbind*
rm -f /usr/lib/check_mk_agent/local/dhcp_lease_check.sh
rm -f /usr/lib/check_mk_agent/local/3600/inspector*

sed -i "s/10.1.1.150/8.8.8.8/g" /etc/resolv.conf 
sed -i "s/10.1.1.151/8.8.4.4/g" /etc/resolv.conf

sed -i "s|define..SMART_HOST|dnl define(\`SMART_HOST|g" /etc/mail/sendmail.mc

service sendmail restart

OTHERTHANEOF

chmod +x /root/runme_before_switching_to_dmz_vlan.sh
