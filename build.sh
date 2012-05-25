#! /bin/bash

# Install ruby
# function install_ruby() {
#   yes | sudo apt-get install ruby
# }
# install_ruby

# Options
# URL=`ruby $LEMPress/scripts/get_ip.rb`
URL="new-wordpress-site.com"

time=`date +%s`


# Configs

$LD="$HOME/LEMPress"

tmux_config="$LEMPress/configs/tmux.conf"

fastcgi_init="$LEMPress/configs/fastcgi-init.sh"
# cat $tmux_config > /new/path/.tmux.conf

# function get_ip() {
#   wget http://checkip.dyndns.com/ &&
#   ruby -e ``
# }

function upgrade() {
  yes | sudo apt-get update
  yes | sudo apt-get upgrade
}

function install_tools() {
  yes | sudo apt-get install openssh-server tmux rsync iptables wget curl build-essential python-software-properties unzip
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
  unzip -d "$HOME/tmp/wordpress-$time" "$HOME/tmp/latest.zip"
  rsync -av --progress "$HOME/tmp/wordpress-$time/wordpress/" "$HOME/sites/$URL/"
  mkdir "$HOME/sites/$URL/logs"
}


# Configure
function configure_virtualhost() {
  sudo cp "$LEMPress/configs/LEMPress-virtualhost.txt" "/etc/nginx/sites-available/$URL"
  sudo sed -i "s/URL/$URL/g" "/etc/nginx/sites-available/$URL"
  sudo ln -s "/etc/nginx/sites-available/$URL" "/etc/nginx/sites-enabled/$URL"
  # sudo rm "/etc/nginx/sites-enabled/default"
}

function configure_fastcgi() {
  sudo cp "$fastcgi_init" "/etc/init.d/php-fastcgi"
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


# Start
function start_servers() {
  sudo service php-fastcgi start
  sudo service nginx reload
  sudo service nginx start
}

# function copy_configs() {
#   cat $tmux_config
# }



# Do it
upgrade

install_tools

install_new_tmux

install_nginx

install_mysql

install_php

# install_varnish

# install_memcached

install_wordpress

configure_virtualhost

configure_fastcgi

start_servers

