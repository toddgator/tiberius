#!/bin/bash
cat << EOF >> /etc/profile.d/zzrbash.sh
#!/bin/bash
if groups |grep -qi "domain users"
then
    if ! groups|egrep -q "linux admins|ProIV"
    then
        export PATH=/usr/pro4/scripts:/usr/pro4/scripts/admin
    else 
	export PATH=$PATH:/usr/pro4/scripts:/usr/pro4/scripts/admin
    fi
fi
if whoami | grep -q "^sdi$"
then
   export PATH=$PATH:/usr/pro4/scripts:/usr/pro4/scripts/admin
fi
EOF

mkdir /opt/util
cat << EOF >> /opt/util/wbash
#!/bin/bash

if groups|grep -qi "domain users"
then
    if groups|egrep -q "linux admins|ProIV" 
    then
        /bin/bash
    else
        /bin/rbash
    fi
else
    /bin/bash
fi
EOF
chmod +x /opt/util/wbash

sed -i "s/template shell = \/bin\/bash/template shell = \/opt\/util\/wbash/g" /etc/samba/smb.conf

