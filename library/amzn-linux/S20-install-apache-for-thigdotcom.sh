#!/usr/bin/env bash
#
# Installs Apache and OpenSSL packages for Amazon Linux

# Package lists for software groups needed by www.thig.com (Wordpress)
APACHE_PKGS="httpd24 mod24_security"
PHP_PKGS="php56 php56-gd php56-xml"
MYSQL_PKGS="mysql php56-mysqlnd"
OPENSSL_PKGS="openssl"

# Install all packages without prompting for user input
echo "Installing packages for Apache, PHP, MySQL client, and OpenSSL..."
yum install -y ${APACHE_PKGS} ${PHP_PKGS} ${MYSQL_PKGS} ${OPENSSL_PKGS}
echo "...done"

# Turn off the "expose_php" option in php.ini
echo "Turning off the \'expose_php\' directive for PHP..."
sed -i 's/expose_php = On/expose_php = Off/g' /etc/php.ini
echo "...done"

# Enable the Apache (httpd) service
echo "Enabling the httpd.service unit for sysctl..."
systemctl enable httpd.service
echo "...done"
