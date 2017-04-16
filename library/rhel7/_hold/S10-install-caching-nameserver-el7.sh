#!/bin/bash
#Tested working 10/20/2016 JCL

yum -y install bind bind-chroot
cd /var/named/chroot/etc

cat << \EOF > /var/named/chroot/etc/named.conf
options {
        listen-on port 53 { 127.0.0.1; any; };
        listen-on-v6 port 53 { ::1; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        recursion yes;
        allow-query     { localhost; };
        allow-query-cache    { localhost; };
        forwarders { 10.1.1.150; 10.1.1.151; 10.3.1.151; 10.3.1.152; };
        empty-zones-enable no;
	version "none";

        dnssec-enable yes;
        dnssec-validation yes;

        auth-nxdomain no;    # conform to RFC1035

        /* Path to ISC DLV key */
        bindkeys-file "/etc/named.iscdlv.key";

        managed-keys-directory "/var/named/dynamic";
};

logging {
        channel default_debug {
                file "data/named.run";
                severity dynamic;
        };
};

include "/etc/named.rfc1912.zones";

EOF
chown root:named /var/named/chroot/etc/named.conf

#Keep NetworkManager from overriding resolv.conf on reboot
IFACE=$(ip link show | grep -v "lo:" | grep UP | awk '{print $2}' | sed "s/://g")
sed -i 's/PEERDNS=yes/PEERDNS=no/g' /etc/sysconfig/network-scripts/ifcfg-${IFACE}


cat << EOF > /etc/resolv.conf
search thig.com
nameserver 127.0.0.1
EOF

systemctl disable named
systemctl stop named*

systemctl enable named-chroot

