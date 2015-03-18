About LEMPress
==============

A WordPress server environment shouldn't be slow or complicated to set up. LEMPress addresses those problems. LEMPress is a super easy to use setup script for creating an optimized WordPress server. LEMPress packs a full LEMP stack (Linux/Nginx/MySQL/PHP) with Varnish and Memcache for caching. With these tools, your site will be prepared for heavy traffic right from the start.


Caching
============

LEMPress gets the server _ready_ to make Wordpress fast, but one step that hasn't been automated yet, is configuring a caching plugin. Because WordPress is dynamic, a content aware caching plugin is ideal. LEMPress has been tested with WP Total Cache, but other plugins may work. There are lots of articles about how to get WP Total Cache installed and configured. In the future, we'll add some supporting documentation for WP Total Cache.


Blog Comments
=============
Because LEMPress is taking advantage of caching via Varnish, it will break Wordpress comments. The solution is to use Disqus. It's free, it's good, use it.


Distros
=======

LEMPress expects and has only been tested with Ubuntu 12.04 LTS x64


How to Use:
========

Create the "deployer" user

        sudo useradd -d /home/deployer -s /bin/bash -G sudo -m deployer
        sudo passwd deployer
        su deployer
        cd ~

Install Git

        yes | sudo apt-get install git-core

Download LEMPress

        git clone git://github.com/okor/LEMPress.git
        cd LEMPress

Setup the server

        bash build_server.sh

Add a Wordpress site

        bash add_site.sh


The `build_server.sh` script will guide you though the WordPress and LEMPress stack install. Once you've set up a WordPress caching plugin (WP Total Cache is recommended), you'll have a highly optimized WordPress site ready for viral loads.
