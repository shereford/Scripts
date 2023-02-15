#!/bin/bash

# Update system packages
yum update -y

# Install Apache
yum install httpd -y

# Start Apache and enable it to start at boot time
systemctl start httpd
systemctl enable httpd

# Install PHP and its dependencies
yum install php php-mysql php-gd php-xml -y

# Install MySQL server and client
yum install mysql-server mysql -y

# Start MySQL and enable it to start at boot time
systemctl start mysqld
systemctl enable mysqld

# Secure the MySQL installation by running the security script
mysql_secure_installation <<EOF

y
password
password
y
y
y
y
EOF

# Add PHP info page to Apache web server
echo "<?php phpinfo(); ?>" > /var/www/html/info.php

# Restart Apache to pick up the PHP info page
systemctl restart httpd
