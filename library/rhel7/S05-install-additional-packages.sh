#!/bin/bash
yum -y install telnet sharutils ssldump sshfs tree haveged
rpm -Uvh "http://thirdparty.thig.com/gnu/parallel-20150722-2.1.noarch.rpm"

# Disabling miller as I dont think anyone is using it.  CH 12192016
#mkdir /tmp/miller
#cd /tmp/miller
#awget "http://thirdparty.thig.com/miller/miller-master.zip"
#unzip miller-master.zip
#cd miller-master
#make
#make install

cd /tmp
mkdir sift
cd sift
wget "http://thirdparty.thig.com/sift/sift_0.3.3_linux_amd64.tar.gz"
tar xvzf sift*.gz
cd sift*
mv sift /bin

# JQ 1.5
cd /usr/bin
wget "http://thirdparty.thig.com/jq/jq"
chmod +x /usr/bin/jq

# haveged: https://wiki.archlinux.org/index.php/Haveged
chkconfig haveged on

# lftp 4.7.6
yum -y install readline-devel ncurses-devel openssl-devel zlib-devel
mkdir /tmp/lftp
cd /tmp/lftp
wget http://thirdparty.thig.com/lftp/lftp-4.7.6.tar.gz
tar xvzf lftp-4.7.6.tar.gz
cd lftp*
./configure --with-openssl
make
make install
cd /etc
cp /opt/sdi/thig-application-configs-global/applications/lftp/lftp.conf /etc


# JVMTOP for jvm profiling
cd /tmp
wget "http://thirdparty.thig.com/jvmtop/jvmtop-0.8.0.tar.gz"
tar xvzf jvmtop-0.8.0.tar.gz
mv jvmtop.sh /bin/jvmtop
mv jvmtop.jar /bin
chmod +x /bin/jvmtop
