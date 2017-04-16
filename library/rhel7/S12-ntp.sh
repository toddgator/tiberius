#!/bin/bash


cat << EOF > /etc/ntp.conf
# Tower Hill time source - currently (2016-10-05) two A records pointing to ADC01 and ADC02
server time.thig.com   burst prefer

driftfile /var/lib/ntp/drift

# Permit time synchronization with our time source, but do not
# permit the source to query or modify the service on this system.
restrict default ignore
restrict -6 default ignore

# Permit all access over the loopback interface.  This could
# be tightened as well, but to do so would effect some of
# the administrative functions.
restrict 192.5.41.40
restrict 10.1.1.150
restrict 127.0.0.1
restrict -6 ::1

# Enable writing of statistics records.
statsdir /var/log/ntpstats/
statistics clockstats cryptostats loopstats peerstats
filegen peerstats file peerstats type day enable

# Disable the monitoring facility to prevent amplification attacks using ntpdc
# monlist command when default restrict does not include the noquery flag. See
# CVE-2013-5211 for more details.
# Note: Monitoring will not be disabled with the limited restriction flag.
disable monitor

EOF

# Check for DMZ and do something different as ADC01 not available.

echo "$(hostname -s)" | egrep -i "xkylex|xflgnv|bflgnvweb|bflgnvslb" && sed -i "s/time.thig.com/tick.usno.navy.mil/g" /etc/ntp.conf
chkconfig ntpd on
service ntpd restart


