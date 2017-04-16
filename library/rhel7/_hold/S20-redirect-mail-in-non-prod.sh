#!/bin/bash
. /etc/sdi/thig-settings 
echo ${ENVIRONMENT} | egrep -i "dmz|prod|beta" && exit
yum -y install sendmail-cf
. /etc/sdi/thig-settings
cat << \EOF >> /etc/mail/sendmail.cf
Mesmtp1025,     P=[IPC], F=mDFMuXa, S=EnvFromSMTP/HdrFromSMTP, R=EnvToSMTP, E=\r\n, L=990,
                T=DNS/RFC822/SMTP,
                A=TCP $h 1025
EOF
cat << EOF >> /etc/mail/mailertable
modelpurr@thig.com    esmtp:mail.thig.com
modelaction@thig.com         esmtp:mail.thig.com
modelactionrp@thig.com    esmtp:mail.thig.com
modelcap@thig.com    esmtp:mail.thig.com
modelclaimreports@thig.com    esmtp:mail.thig.com
modelclaimsincoming@thig.com    esmtp:mail.thig.com
modelclaimsrp@thig.com    esmtp:mail.thig.com
modelthcs@thig.com    esmtp:mail.thig.com
modelclarendon@thig.com    esmtp:mail.thig.com
modelemailreceiver@thig.com    esmtp:mail.thig.com
modelcommdecquote@thig.com    esmtp:mail.thig.com
modelcommreturn@thig.com    esmtp:mail.thig.com
modelcommercialuwr@thig.com    esmtp:mail.thig.com
modelcommquotes@thig.com    esmtp:mail.thig.com
modelcomminspec@thig.com    esmtp:mail.thig.com
modelinspections@thig.com    esmtp:mail.thig.com
modellossdec@thig.com    esmtp:mail.thig.com
modelopsaction@thig.com    esmtp:mail.thig.com
modelparkinspections@thig.com    esmtp:mail.thig.com
modelqa@thig.com    esmtp:mail.thig.com
modelthcscap@thig.com    esmtp:mail.thig.com
modelwater@thig.com    esmtp:mail.thig.com
modelpurr2@thig.com    esmtp:mail.thig.com
modelcommendorsement@thig.com    esmtp:mail.thig.com
redirectedemail.thig.com    esmtp1025:mailcatcher${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com
.               esmtp1025:mailcatcher${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com
..              esmtp1025:mailcatcher${ENVIRONMENT_SUBDOMAIN_FOR_URLS}.thig.com
EOF

service sendmail restart
