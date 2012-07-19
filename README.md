**LEMPress is currently being developed and is not ready for use. If you've stumbled across this repository somehow and your interested in using LEMPress, add it to you watch list and check back regularly for the first stable release.**


About LEMPress
=========

LEMPress is a super easy to use build script for setting up an optimized WordPress server. The WordPress environment shouldn't be slow or complicated to set up. With LEMPress, it's easy, your site will be ready to take on some beat down traffic.


Strategy
========

LEMPress strives to get the highest performance possible while keeping stability and security in mind. All packages come straight from official Ubuntu repositories, so it's easy to update.


About the Stack
===============

LEMPress packs a full LEMP stack (Linux/Nginx/MySQL/PHP) in one easy install. Varnish and Memcache are also come bundled. With these tools, your site will be prepared for heavy traffic right out of the gates.


Dependencies
============

LEMPress gets the server _ready_ to make Wordpress fast, but one step that hasn't been automated yet, is configuring a cacheing plugin. Because WordPress is dynamic, a content aware caching plugin is ideal. LEMPress has been tested with WP Total Cache, but other plugins may work. There are lots of articles about how to get WP Total Cache installed and configured. In the future, we'll add some supporting documentation for WP Total Cache.


Blog Comments
=============
Because LEMPress is taking advantage of cacheing via Varnish, it will break Wordpress comments. The solution is to use Disqus. It's free, it's good, use it.


Supported Linux Operating Systems
=================================

Ubuntu 12.04 LTS x64


How to Use:
========

Create the "deployer" user. Make sure to record you deployer password. You'll need it to install plugins and upgrade WordPress

        sudo useradd -d /home/deployer -s /bin/bash -G sudo -m deployer
        sudo passwd deployer
        su deployer
        cd ~

Download and run the script.

        yes | sudo apt-get install git-core
        git clone git://github.com/okor/LEMPress.git
        cd LEMPress
        bash build.sh

The `build.sh` script will guide you though the WordPress and LEMPress stack install. Once you've set up a WordPress cacheing plugin (WP Total Cache is recommended), you'll have a highly optimized WordPress site ready for viral loads.