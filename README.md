**LEMPress is currently being developed and is not ready for use. If you've stumbled across this repository somehow and your interested in using LEMPress, add it to you watch list and check back regularly for the first stable release.**

About LEMPress
=========
  LEMPress is a super easy to use build script for setting up an optimized WordPress server. The WordPress environment shouldn't be slow or complicated to set up. With LEMPress, it's easy, your site will be ready to take on the world's toughtest traffic.

Strategy
=====
  LEMPress strives to get the highest performance possible while keeping stability and security in mind. That's why instead of using the latest PHP build from a PPA or source, it uses good ol' dependable core Ubuntu repos. That also means LEMPress uses fast cgi instead of the faster fpm, again for stability and security. The same goes for Nginx and MySQL versions. Like your best friend, you can count on LEMPress.

About the Stack
==========
  LEMPress packs a full LEMP stack (Linux/Nginx/MySQL/PHP) in one easy install. Varnish and Memcache are also come bundled. With these tools, your site will be prepared for heavy traffic right out of the gates.

Supported Linux Operating Systems
=========
  Ubuntu 12.04 LTS x64
  ... More Coming Soon

How to Install:
========

Installing LEMPress as root _will not work._ While logged in as your admin user, enter the following commands:
        yes | sudo apt-get install git-core           # This installs git, if you don't have it already
        git clone git://github.com/okor/LEMPress.git  # Downloads LEMPress' intialization scripts
        cd LEMPress                                   # Navigate to the recently installed LEMPress folder
        bash build.sh                                 # Install LEMPress -- the magic begins

The `build.sh` command will guide you though the WordPress and LEMPress stack install. When you're done, you'll have a highly optimized WordPress server ready for viral loads. You now have permission to create!
