#! /bin/bash

# Install ruby
# function install_ruby() {
#   yes | sudo apt-get install ruby
# }
# install_ruby

# Options
# URL=`ruby $PWD/scripts/get_ip.rb`
URL="new-wordpress-site.com"


# Configs

tmux_config="$PWD/configs/tmux.conf"
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

function install_nginx() {
  sudo add-apt-repository ppa:nginx/stable
  sudo apt-get update
  yes | sudo apt-get install nginx
}

function install_mysql() {
  yes | sudo apt-get install mysql-server
}

function install_php() {
  yes | sudo apt-get install php5-common php5-cli php5-cgi php5-fpm php5-mcrypt php5-mysql
}

function install_varnish() {
  yes | sudo apt-get install varnish
}

function install_memcached() {
  yes | sudo apt-get install memcached 
  # php5-memcache
}


function install_wordpress() {
  time=`date +%s`
  mkdir "$HOME/tmp"
  mkdir "$HOME/sites"
  mkdir "$HOME/sites/$URL/"
  wget -P "$HOME/tmp" http://wordpress.org/latest.zip
  unzip -d "$HOME/tmp/wordpress-$time" "$HOME/tmp/latest.zip"
  cp -R "$HOME/tmp/wordpress-$time/wordpress/" "$HOME/sites/$URL/"
  mkdir "$HOME/sites/$URL/logs"
}



function start_servers() {
  sudo /etc/init.d/nginx start
}

# function copy_configs() {
#   cat $tmux_config
# }



# Do it
upgrade

install_tools

install_nginx

install_mysql

install_php

install_varnish

install_memcached

install_wordpress



# start_servers

