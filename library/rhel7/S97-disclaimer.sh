#!/bin/bash
#
# Adding default THIG login disclaimer.

cat << EOF > /etc/issue.net

**********************************************************************************************

CONTINUED ACTION WITHIN THIS TERMINAL SESSION IMPLIES CONSENT TO THE FOLLOWING:

This system is for the use of authorized users only. By logging onto this system, anyone        
using this system expressly consents to all monitoring, recording and disclosure of any 
information, and is advised that if such monitoring reveals possible evidence of criminal       
activity, THIG may provide the evidence of such monitoring to law enforcement officials.

Further, by logging onto this system, you authorize, approve, and consent to silent      
monitoring by THIG and its employees or agents of any telephone communications to which 
you are a party and which uses THIG's telephones and equipment. You also consent that 
portions of this telephone monitoring may be recorded and used for future instructional 
purposes.

Finally, by logging into this system, you waive and release THIG, its corporate affiliates, 
directors, employees, and agents from any and all rights and/or claims for damages, 
demands or actions whatsoever in any manner by reason of telephone and/or computer monitoring

Press <Ctrl-D> if you are not an authorized user

**********************************************************************************************   

EOF

cat << EOF > /etc/issue

**********************************************************************************************

CONTINUED ACTION WITHIN THIS TERMINAL SESSION IMPLIES CONSENT TO THE FOLLOWING:

This system is for the use of authorized users only. By logging onto this system, anyone
using this system expressly consents to all monitoring, recording and disclosure of any
information, and is advised that if such monitoring reveals possible evidence of criminal
activity, THIG may provide the evidence of such monitoring to law enforcement officials.

Further, by logging onto this system, you authorize, approve, and consent to silent
monitoring by THIG and its employees or agents of any telephone communications to which
you are a party and which uses THIG's telephones and equipment. You also consent that
portions of this telephone monitoring may be recorded and used for future instructional
purposes.

Finally, by logging into this system, you waive and release THIG, its corporate affiliates,
directors, employees, and agents from any and all rights and/or claims for damages,
demands or actions whatsoever in any manner by reason of telephone and/or computer monitoring

Press <Ctrl-D> if you are not an authorized user

**********************************************************************************************   


\S
Kernel \r on an \m


EOF

sed -i 's/#Banner none/Banner \/etc\/issue.net/g' /etc/ssh/sshd_config
systemctl restart sshd.service
