#! /bin/bash

source './lib/main.sh'

get_website_url
install_wordpress

create_passwords
create_db
configure_wordpress

configure_virtualhost
start_servers

ip_dump