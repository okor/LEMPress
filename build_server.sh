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