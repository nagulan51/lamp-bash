if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
sudo apt update
sudo apt upgrade -y
sudo apt install apache2 -y
#need to debian to check 
sudo apt install libapache2-mod-php -y

sudo apt install php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath -y
sudo apt install -y php-{bcmath,bz2,intl,gd,mbstring,mysql,zip,common} -y
sudo apt install mariadb-server -y
# sudo mysql_secure_installation
sudo mysql -e "SET PASSWORD FOR root@localhost = PASSWORD('!23U1akLwrpB');FLUSH PRIVILEGES;" 
printf "123\n n\n n\n n\n y\n y\n y\n" | sudo mysql_secure_installation

sudo apt install wget unzip -y
cd /var/www/html
wget https://fr.wordpress.org/latest-fr_FR.zip
unzip latest-fr_FR.zip
cd wordpress && mv * /var/www/html
chmod -R 777 /var/www/html
sudo chown -R www-data:www-data /var/www/html
rm -rf index.html
sudo mysql -u root mysql<<EOF
CREATE USER 'kingkong'@'localhost' IDENTIFIED BY 'ykYWuL8w60#v';
GRANT ALL PRIVILEGES ON * . * TO 'kingkong'@'localhost';
FLUSH PRIVILEGES;

create database wordpress;
GRANT ALL ON wordpress.* TO 'kingkong'@localhost;
FLUSH PRIVILEGES;
\q
EOF

sudo service apache2 restart
# sudo systemctl restart apache2