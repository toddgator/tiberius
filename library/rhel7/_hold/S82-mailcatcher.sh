#!/bin/bash
yum -y install sqlite-devel
useradd -d /opt/mailcatcher mailcatcher
cd /tmp
wget http://thirdparty.thig.com/ruby/ruby-2.1.1.tar.gz
tar xvzf ruby-2.1.1.tar.gz
cd ruby-2.1.1
./configure --prefix=/usr
make
make install

rm -rf /tmp/ruby-2.1.1

# Install RubyGems 
cd /tmp 
wget http://thirdparty.thig.com/ruby/rubygems-1.8.25.tgz
tar xvzf rubygems-1.8.25.tgz
cd rubygems-1.8.25
ruby setup.rb config
ruby setup.rb setup
ruby setup.rb install

rm -rf /tmp/rubygems-1.8.25 
cd /tmp
gem install mailcatcher
ln -s /etc/httpd/conf.d/sites-available/mailcatcher_hosts.conf /etc/httpd/conf.d/sites-enabled/
ln -s /opt/sdi/sdi_service_scripts/init/mailcatcher /etc/init.d/
ln -s /opt/sdi/sdi_service_scripts/init/mailcatcher /etc/init.d/sdi.mailcatcher
chkconfig sdi.mailcatcher on

