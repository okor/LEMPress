#! /bin/bash

source './lib/main.sh'



upgrade

install_tools
install_new_tmux
install_nginx
install_php
install_memcached
install_varnish
install_mysql

configure_fastcgi
configure_tmux
configure_bash
configure_varnish

start_servers

echo -e "\033[32m Your server is set up and ready to start adding Wordpress sites. Just run 'bash add_site.sh' to add 1 or more sites. \033[0m"