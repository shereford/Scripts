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

# Download and extract the latest WordPress archive
wget -qO- https://wordpress.org/latest.tar.gz | tar xvz -C /var/www/html/

# Set permissions for the WordPress files
chown -R apache:apache /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# Create a WordPress configuration file
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Set the database name, username, and password in the WordPress configuration file
sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/root/g" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/password/g" /var/www/html/wordpress/wp-config.php

# Add WordPress configuration to Apache configuration
cat <<EOT > /etc/httpd/conf.d/wordpress.conf
<Directory /var/www/html/wordpress/>
    AllowOverride All
</Directory>
EOT

# Restart Apache to pick up the configuration changes
systemctl restart httpd
