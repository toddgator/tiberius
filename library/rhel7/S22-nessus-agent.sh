#!/bin/bash
#
# Installs/Configures Nessus agent.

. /etc/sdi/thig-settings

rpm -Uvh http://thirdparty.thig.com/tenable/agents/${OSANDVERSION}/NessusAgent-${OSANDVERSION}-latest.rpm

# Remove any old associations
# CMH: fairly certain this doesn't work though
/opt/nessus_agent/sbin/nessuscli agent unlink --force
sleep 5

# Install new agent with new UUID based on network location
export ROLE=$(echo ${HOSTNAME:6:3} | tr [:upper:] [:lower:])
export ENVIRONMENT=$(echo ${HOSTNAME:0:1} | tr [:upper:] [:lower:])
export SUBENVIRONMENT=$(echo ${HOSTNAME:9:1} | tr [:upper:] [:lower:])
echo $ROLE
echo $ENVIRONMENT
echo $SUBENVIRONMENT

case $ENVIRONMENT in
    S|s)
      agent_group="Linux Servers - Prod - Internal"
    ;;
    X|x)
      agent_group="Linux Servers - Prod - DMZ"
    ;;
    B|b)
      case $ROLE in 
        web)
          agent_group="Linux Servers - Beta - DMZ"
        ;;
        web)
          agent_group="Linux Servers - Beta - DMZ"
        ;;
        *)
          agent_group="Linux Servers - Beta - Internal"
        ;;
      esac
    ;;
    D|d)
        case $SUBENVIRONMENT in
        O|o)
          agent_group="Linux Servers - Dev - Orange"
        ;;
        Y|y)
          agent_group="Linux Servers - Dev - Yellow"
        ;;
        *)
          agent_group="Linux Servers - Dev - Unknown"
        ;;
        esac
    ;;
    Q|q)
        case $SUBENVIRONMENT in
        U|u)
          agent_group="Linux Servers - QA - UAT"
        ;;
        Q|q)
          agent_group="Linux Servers - QA - UnitQA"
        ;;
        R|r)
          agent_group="Linux Servers - QA - Red"
        ;;
        G|g)
          agent_group="Linux Servers - QA - Green"
        ;;
        P|p)
          agent_group="Linux Servers - QA - Purple"
        ;;
        0)
          agent_group="Linux Servers - QA - Unknown"
        ;;
        *)
        ;;
        esac
    ;;
    *)
          agent_group="Linux Servers - Unknown - Unknown"
    ;;
esac

/opt/nessus_agent/sbin/nessuscli agent link --key=2b1a12aab851259dd90a315f88a5543584ebd4733892788fbccb1560a7b74737 --name=$(hostname) --groups="${agent_group}" --host=nflgnvtnm01.thig.com --port=8834

/sbin/service nessusagent start
chkconfig nessusagent on
