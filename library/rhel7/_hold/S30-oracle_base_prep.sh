#!/bin/bash
# Role specific setup
##
    #Install additional packages per 11gR2 requirements:
    # http://docs.oracle.com/cd/E11882_01/install.112/e24321/pre_install.htm#LADBI1095
    yum install -y compat-libcap1 compat-libstdc++-33 libaio-devel ksh unixODBC unixODBC-devel readline-devel rlwrap
    yum install -y xorg-x11-apps xorg-x11-xauth
    ln -s /usr/lib64/libodbc.so.2.0.0 /usr/lib64/libodbc.so.1

    useradd oracle
    groupadd oinstall
    groupadd dba
    usermod -g oracle -G dba oracle

    echo "User_Alias DBAS = jkern, bjohnston" >> /etc/sudoers
    echo "DBAS ALL=(oracle) NOPASSWD: ALL" >> /etc/sudoers

    wget -q http://sflgnvlms01.thig.com/inhouse/oracle/oracle.sh -O /etc/profile.d/oracle.sh
    wget -q http://sflgnvlms01.thig.com/inhouse/oracle/xfu -O /usr/local/bin/xfu
    chmod +x /usr/local/bin/xfu

## Add oracle stuff to profile
echo '
# User specific environment and startup programs
JAVA_HOME=/opt/java
TNS_ADMIN=$ORACLE_HOME/network/admin
alias 'java'=$JAVA_HOME/bin/java

PATH=$PATH:$HOME/bin

export PATH JAVA_HOME TNS_ADMIN

if [ -f /etc/oraAlias.ksh ]; then
        . /etc/oraAlias.ksh
fi

export TERM=xterm
' >> /home/oracle/.bash_profile

# Add oracle stuff to /etc/profile
echo '
export PERL5LIB=/u01/app/oracle/product/12.1.0/db_1/perl/lib/site_perl/5.10.0/x86_64-linux-thread-multi
[[ -z $TERM ]] && export TERM=xterm
' >> /etc/profile

# Add oracle stuff to .bashrc
echo '
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=$ORACLE_BASE/product/12.1.0/db_1
PATH=$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$HOME/bin
LD_LIBRARY_PATH=$ORACLE_HOME/lib
ORACLE_SID="oraprod"
ORACLE_ENV=NO
export ORACLE_BASE ORACLE_HOME PATH LD_LIBRARY_PATH ORACLE_SID

# User specific aliases and functions
' >> /home/oracle/.bashrc

cat << \EOF >> /etc/profile.d/oracle.sh
#Updated for RHEL6
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=${ORACLE_BASE}/product/12.1.0/db_1
PATH=${PATH}:${ORACLE_HOME}/bin:${ORACLE_HOME}/OPatch:${HOME}/bin:/home/oracle/bin
LD_LIBRARY_PATH=${ORACLE_HOME}/lib
export ORACLE_BASE ORACLE_HOME PATH LD_LIBRARY_PATH

alias dbs='cd ${ORACLE_HOME}/dbs'
alias diag='cd ${ORACLE_BASE}/diag'
alias home='cd ${ORACLE_HOME}'
alias alert='tail -300 ${ORACLE_BASE}/diag/rdbms/${ORACLE_SID}/${ORACLE_SID}/trace/alert_${ORACLE_SID}.log|less -R'
alias pfile='cd ${ORACLE_HOME}/dbs'
alias rman='rlwrap rman'
alias scripts='cd ${ORACLE_BASE}/admin/scripts'
alias sqlplus='rlwrap sqlplus'
alias tns='cd ${ORACLE_HOME}/network/admin'
alias suo='sudo -u oracle -i'
alias trc='cd ${ORACLE_BASE}/diag/rdbms/${ORACLE_SID}/${ORACLE_SID}/trace'
EOF
chmod +x /etc/profile.d/oracle.sh

# Disable Transparent Hugepages per Oracle technote: https://support.oracle.com/epmos/faces/DocContentDisplay?id=1557478.1 
sed -i "s/quiet/quiet transparent_hugepage=never/g" /boot/grub/grub.conf 

# Create an integer shell script variable to set SHMMAX to half the memory of the host
# https://docs.oracle.com/database/121/LADBI/app_manual.htm#LADBI7866
# https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=223226001288617&id=567506.1&_afrWindowMode=0&_adf.ctrl-state=11n1tdpatb_54

declare -i memory_in_kb
memory_in_kb=$(cat /proc/meminfo | grep MemTotal | awk '{print $2}')
# Set to half the physical memory in bytes
declare -i max_SHMMAX_value

# Set to KB installed in the Physical machine
max_SHMMAX_value=${memory_in_kb}
# Change to bytes
max_SHMMAX_value=${max_SHMMAX_value}*1024
# Set to half the physical memory in the machine in bytes
max_SHMMAX_value=${max_SHMMAX_value}/2


# Create an integer shell script variable to set SHMMALL to memory pages to provide to Oracle
declare -i SHMMALL_value
declare -i OS_PAGE_SIZE
OS_PAGE_SIZE=$(getconf PAGE_SIZE)
# Set to KB installed in the physical machine
SHMMALL_value=${memory_in_kb}
# Change to bytes
SHMMALL_value=${SHMMALL_value}*1024
# Divide by OS Page Size
SHMMALL_value=${SHMMALL_value}/${OS_PAGE_SIZE}

# Remove default values 
sed -i "s/kernel.shmmax = .*//g" /etc/sysctl.conf
sed -i "s/kernel.shmall = .*//g" /etc/sysctl.conf


# Change to sysrq=1 per oraprod01 config
sed -i "s/kernel.sysrq = 0/kernel.sysrq = 1/g" /etc/sysctl.conf

echo "
### Oracle Customizations

# https://docs.oracle.com/cd/E18248_01/doc/install.112/e16763/pre_install.htm
# Enable Core Dump Creation
fs.suid_dumpable = 1

# Controls whether core dumps will append the PID to the core filename
# Useful for debugging multi-threaded applications
# Disabled as this is in the default RHEL6 sysctl.conf
# kernel.core_uses_pid = 1

# Increase maximum concurrent asynchronous I/O requests
# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD says to set to 1048576, oraprod01 had 3M though
fs.aio-max-nr = 3145728

# Shared memory and SHMMAX and SHMMALL: http://seriousbirder.com/blogs/linux-understanding-shmmax-and-shmall-settings/
# SHMMAX is the maximum size of a single shared memory segment.  It's size is represented in bytes.  
kernel.shmmax = ${max_SHMMAX_value}
# SHMALL is the sum of all shared memory segments on the whole system, it is represented in PAGES, not bytes.
kernel.shmall = ${SHMMALL_value}

# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCBCFDI
kernel.shmmni = 4096

# semaphores: semmsl, semmns, semopm, semmni
# https://docs.oracle.com/database/121/LADBI/app_manual.htm#LADBI7866
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500

# Increase the max open file handles
# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD
# Disabled as this is set in the kickstart
# fs.file-max = 6815744

# Allow oracle to be able to listen on lower ports
# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD
net.ipv4.ip_local_port_range = 9000 65500

# Disabling IPC Tuning per rpm spec file mentioned here: https://blogs.oracle.com/linux/entry/oracle_rdbms_server_11gr2_pre
# Also Disabled as default rhel6 install sets both to 65536
# rpmspec: https://github.com/genebean/oracle-rdbms-server-11gR2-preinstall/blob/master/oracle-rdbms-server-11gR2-preinstall.spec
# Basically, the rpm distributed by Oracle for installation has removed setting these differently from defaults
# kernel.msgmni = 2878
# kernel.msgmax = 65536

# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD
net.core.rmem_default = 262144
net.core.wmem_default = 262144

# https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD
# Disabled as higher limit set with default RHEL6 install than recommended in above support documentation.
# net.core.rmem_max = 4194304
# net.core.wmem_max = 1048586

# Turn down the kswapd swappiness
vm.swappiness=5

# Disabling tcp low latency per http://hackingnasdaq.blogspot.com/2010/01/myth-of-procsysnetipv4tcplowlatency.html
#net.ipv4.tcp_low_latency=1
" >> /etc/sysctl.conf

# Per https://docs.oracle.com/database/121/LTDQI/toc.htm#BHCCADGD, set memlock soft/hard to be 90% of physical memory
declare -i memlock_value
memlock_value=$(echo "${memory_in_kb}*0.9"|bc | sed "s/\..//g")

echo "

# Taken from http://oracle-base.com/articles/11g/oracle-db-11gr2-installation-on-oracle-linux-5.php
#
oracle          hard    nproc            131072
oracle          soft    nproc            131072
oracle          soft    stack            10240

# Taken from: https://docs.oracle.com/cd/E37670_01/E37355/html/ol_config_hugepages.html
#
oracle          soft    memlock          ${memlock_value}
oracle          hard    memlock          ${memlock_value}

" >> /etc/security/limits.conf


# Fix snapdrive.conf to standard config
echo '
enable-implicit-host-preparation=on  # Enable implicit host preparation for LUN creation
multipathing-type="NativeMPIO"  # Multipathing software to use when more than one multipathing solution is available. Possible values are 'NativeMPIO' or 'none' 
san-clone-method="unrestricted"  # Clone methods for snap connect: unrestricted, optimal or lunclone
' >> /opt/NetApp/snapdrive/snapdrive.conf 

# Allow sudo use
chmod u+s /usr/bin/sudo
