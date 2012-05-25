#! /bin/bash


# Don't change these
TIME_NOW=`date +%s`
LEMPress="$HOME/LEMPress"
DEFAULT_URL="new-wordpress-site.com"
URL=""
DB_NAME=""
DB_USER=""
DB_PASSWORD=""
DB_SALT=""
DB_PREFIX=""


# Change these if you have alternate configuration files
TMUX_CONFIG="$LEMPress/configs/tmux.conf"
FASTCGI_INIT="$LEMPress/configs/fastcgi-init.sh"



function get_website_url() {
  echo -n "Enter website URL [DEFAULT:new-wordpress-site.com]: "
  read USER_URL
  if [ -z $USER_URL ]
  then
    URL=$DEFAULT_URL
  else
    URL=$USER_URL
  fi
  echo "URL set to: $URL"
}





# Upgrade

function upgrade() {
  yes | sudo apt-get update
  yes | sudo apt-get upgrade
}

# Install

function install_tools() {
  yes | sudo apt-get install openssh-server tmux rsync iptables wget curl build-essential python-software-properties unzip htop pwgen
}

function install_new_tmux() {
  yes | sudo apt-get install build-essential debhelper diffstat dpkg-dev fakeroot g++ g++-4.4 html2text intltool-debian libmail-sendmail-perl libncurses5-dev libstdc++6-4.4-dev libsys-hostname-long-perl po-debconf quilt xz-utils libevent-1.4-2 libevent-core-1.4-2 libevent-extra-1.4-2 libevent-dev
  DOWNLOAD_URL="http://superb-sea2.dl.sourceforge.net/project/tmux/tmux/tmux-1.6/tmux-1.6.tar.gz"
  wget -P "$HOME/tmp" $DOWNLOAD_URL
  cd "$HOME/tmp"
  tar xvvf tmux-1.6.tar.gz
  cd tmux-1.6/
  ./configure --prefix=/usr
  make
  sudo make install
}

function install_nginx() {
  yes | sudo apt-get install nginx
}

function install_mysql() {
  yes | sudo apt-get install mysql-server
}

function install_php() {
  yes | sudo apt-get install php5-common php5-cli php5-cgi php5-mcrypt php5-mysql
}


function install_ruby() {
  yes | sudo apt-get install ruby
}

# function install_varnish() {
#   yes | sudo apt-get install varnish
# }

# function install_memcached() {
#   yes | sudo apt-get install memcached 
#   # php5-memcache
# }


function install_wordpress() {
  mkdir "$HOME/tmp"
  mkdir "$HOME/sites"
  mkdir "$HOME/sites/$URL/"
  wget -P "$HOME/tmp" http://wordpress.org/latest.zip
  unzip -d "$HOME/tmp/wordpress-$TIME_NOW" "$HOME/tmp/latest.zip"
  rsync -av --progress "$HOME/tmp/wordpress-$TIME_NOW/wordpress/" "$HOME/sites/$URL/"
  mkdir "$HOME/sites/$URL/logs"
}




# Configure

function configure_virtualhost() {
  sudo cp "$LEMPress/configs/LEMPress-virtualhost.txt" "/etc/nginx/sites-available/$URL"
  sudo sed -i "s/URL/$URL/g" "/etc/nginx/sites-available/$URL"
  sudo ln -s "/etc/nginx/sites-available/$URL" "/etc/nginx/sites-enabled/$URL"
  sudo rm "/etc/nginx/sites-enabled/default"
}

function configure_fastcgi() {
  sudo cp "$FASTCGI_INIT" "/etc/init.d/php-fastcgi"
  sudo chmod +x "/etc/init.d/php-fastcgi"
}

function configure_tmux() {
  cp "$LEMPress/configs/tmux.conf" "$HOME/.tmux.conf"
}

function configure_bash() {
  cp "$HOME/.bashrc" "$HOME/.bashrc~backup"
  cp "$LEMPress/configs/bashrc" "$HOME/.bashrc"

  sudo cp /root/.bashrc /root/.bashrc~backup
  sudo cp "$LEMPress/configs/bashrc" /root/.bashrc
}



function create_passwords() {
  DB_NAME="pwgen -Bs 10 1"
  DB_USER="pwgen -Bs 10 1"
  DB_PASSWORD="pwgen -Bs 40 1"
  DB_SALT="pwgen -Bs 80 1"
  DB_PREFIX="`pwgen -0 5 1`_"
}

function create_db() {
  bash "$LEMPress/scripts/create_db.sh $DB_NAME $DB_USER $DB_PASSWORD"
}

function configure_wordpress() {
  cp "$HOME/sites/$URL/wp-config-sample.php" "$HOME/sites/$URL/wp-config.php"
  #db name
  sed -i "s/database_name_here/$DB_NAME/g" "$HOME/sites/$URL/wp-config.php"
  #db user
  sed -i "s/username_here/$DB_USER/g" "$HOME/sites/$URL/wp-config.php"
  #db password
  sed -i "s/password_here/$DB_PASSWORD/g" "$HOME/sites/$URL/wp-config.php"
  #db salt
  sed -i "s/put your unique phrase here/$DB_SALT/g" "$HOME/sites/$URL/wp-config.php"
  #db prefix
  sed -i "s/wp_/$DB_PREFIX/g" "$HOME/sites/$URL/wp-config.php"
}





function start_servers() {
  sudo service php-fastcgi start
  sudo service nginx reload
  sudo service nginx start
}





# Do it
get_website_url

upgrade

install_ruby
install_tools
install_new_tmux
install_nginx
install_mysql
install_php
install_wordpress

create_passwords
create_db
configure_wordpress

configure_virtualhost
configure_fastcgi
configure_tmux
configure_bash

start_servers





PUBLIC_IP=`ruby $LEMPress/scripts/get_ip.rb`
echo -e "\033[32m" && \
echo -e "\033[32mOk, you're all done. Point your browser at your server (URL: $URL, IP: $PUBLIC_IP) , and you should see a new wordpress site." && \
echo -e "\033[32m" && \
echo -e "\033[32mHere's some local network information about this machine." && \
ifconfig | grep "inet addr" && \
echo -e "\033[32m "







