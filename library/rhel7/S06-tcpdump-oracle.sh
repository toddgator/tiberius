#!/bin/bash
#
# Install 'tcpdump-oracle.sh' script.

cat << \EOF >> /bin/tcpdump-oracle.sh
#!/bin/bash
tcpdump tcp port 1521 -A -s0 | awk '$1 ~ "ORA-" {i=1;split($1,t,"ORA-");while (i <= NF) {if (i == 1) {printf("%s","ORA-"t[2])}else {printf("%s ",$i)};i++}printf("\n")}'
EOF
chmod +x /bin/tcpdump-oracle.sh
