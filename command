sudo apt update
sudo apt install apache2

sudo apt install mariadb-server mariadb-client
sudo mysql_secure_installation

sudo apt install php php-common php-mysql php-gd php-cli 

sudo apt install phpmyadmin
sudo systemctl restart apache2

sudo cp /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo a2enconf phpmyadmin
sudo systemctl restart apache2

sudo mysql -u root -p
CREATE USER 'user_name'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'user_name'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;




sudo nano /etc/apache2/conf-available/phpmyadmin.conf

<Directory /usr/share/phpmyadmin>
....
...

AllowOverride All
...
...


sudo nano /usr/share/phpmyadmin/.htaccess

AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user

sudo nano /usr/share/phpmyadmin/libraries/sql.lib.php
sudo nano /usr/share/phpmyadmin/libraries/plugin_interface.lib.php
/*
if ($options != null && count($options) > 0) {

Add (array) or replace with this

if ($options != null && count((array)$options) > 0)
*/


//add Doamin
sudo mkdir -p /var/www/html/mobarok.tk/public_html
sudo chown -R mobarok69:mobarok69 /var/www/html/mobarok.tk/*

//create demo page for test
sudo nano /var/www/html/mobarok.tk/public_html/index.html

<html>
 <head>
 <title>mobarok</title>
 </head>
 <body>
 <h1>Hello, This is a test page for ostechnix1.lan website</h1>
 </body>
</html>


sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/mobarok.tk.conf
sudo nano /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/mobarok.tk.conf



sudo a2dissite 000-default.conf
sudo a2ensite mobarok.tk.conf

sudo systemctl restart apache2

//ssl
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-apache
sudo apache2ctl configtest
sudo systemctl reload apache2
sudo certbot --apache -d mobarok.tk -d www.mobarok.tk

sudo certbot renew --dry-run


// permission
sudo chown -R mobarok69 /var/www/*

//slim frame work problem
sudo nano /etc/apache2/apache2.conf
//Add this Line
<Directory /var/www/html/mobarok.me/public_html/>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
service apache2 restart


//disable ip access
<VirtualHost *:80>
ServerName localhost
Redirect 403 /
</VirtualHost>
<VirtualHost *:443>
ServerName localhost
Redirect 403 /


..
..

..
</VirtualHost>
