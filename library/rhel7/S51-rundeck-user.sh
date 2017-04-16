#!/bin/bash

. /etc/sdi/thig-settings

###Logic to narrow shot grouping

if [[ -z "$ENVIRONMENT" ]]; then echo "No environment variable defined" && exit 0;
elif [[ ! -d "/opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/certs/" ]]; then echo "Needed pubkey directory doesn't exist" && exit 0; 
elif [[ `cat /etc/passwd | grep "rundeck"` ]]; then echo "Already a user Rundeck on this server" && exit 0;


###Add Rundeck user w privileges and import appropriate SSH public keys

else
	useradd rundeck && echo "Rundeck User Created"
	mkdir -p /home/rundeck/.ssh
	cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/certs/id_rsa.${ENVIRONMENT}.pub >> /home/rundeck/.ssh/authorized_keys && echo "Pub Keys imported"
	chmod 755 /home/rundeck/.ssh/
	chmod 644 /home/rundeck/.ssh/authorized_keys
	chown -R rundeck:rundeck /home/rundeck/		

###Uncomment sudoers aliases for Storage and Delegating command groups

	sed -i 's/# Cmnd_Alias STORAGE/Cmnd_Alias STORAGE/g' /etc/sudoers
	sed -i 's/# Cmnd_Alias DELEGATING/Cmnd_Alias DELEGATING/g' /etc/sudoers

###Add Rundeck "Power User" privileges and restrictions to /etc/sudoers
		
	cat << EOF >> /etc/sudoers

## Rundeck User Blacklist
Cmnd_Alias BLACKLIST = /usr/bin/su, /usr/sbin/visudo, /bin/passwd

Defaults:rundeck !requiretty
rundeck ALL=(root) NOPASSWD: ALL,!BLACKLIST,!DELEGATING,!STORAGE

EOF
	
echo "Sudo rights set for Rundeck User"

###Add additional SSH pubkeys based on dev and qa major environments

	case `hostname -s | cut -c1` in
		d|D)
		cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/certs/id_rsa.dev.pub >> /home/rundeck/.ssh/authorized_keys
		;;
		q|Q)
		cat /opt/sdi/thig-application-configs-global/roles/flgnv/RHEL7/rdk/all/certs/id_rsa.qa.pub >> /home/rundeck/.ssh/authorized_keys
		;;
	esac
echo "SUCCESS!"
fi





