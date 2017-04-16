#!/bin/bash
cat << \EOF >> /root/sanitize-me.sh
#!/bin/bash
for VOL in $@
do 
        echo -n $VOL
        DEV=$(sanlun lun show all |grep $VOL |tail -1 | awk '{print $3}'|cut -f 3 -d '/')
        MDID=$(multipath -ll|grep $DEV -B7 |grep dm- |tail -1| cut -f 1 -d " ")
        echo -n " $DEV $MDID "; df -h |grep $MDID -A1 |tr -d "\n"|awk '{print $6}'|tr -d "\n"
        echo;
done
EOF
chmod +x /root/sanitize-me.sh
