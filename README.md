**LEMPress is currently being developed and is not ready for use. If you've stumbled across this repository somehow and your interested in using LEMPress, add it to you watch list and check back regularly for the first stable release.**

About LEMPress
=========
  LEMPress is a super easy to use build script for setting up an optimized WordPress server. The WordPress environment shouldn't be slow or complicated to set up. With LEMPress, it's easy, your site will be ready to take on the world's toughtest traffic.

Strategy
=====
  LEMPress strives to get the highest performance possible while keeping stability and security in mind. All packages come straight from official Ubuntu repositories, which makes updating packages much easier.

About the Stack
==========
  LEMPress packs a full LEMP stack (Linux/Nginx/MySQL/PHP) in one easy install. Varnish and Memcache are also come bundled. With these tools, your site will be prepared for heavy traffic right out of the gates.

Supported Linux Operating Systems
=========
  Ubuntu 12.04 LTS x64

How to Use:
========

Create the "deployer" user.

        sudo useradd -d /home/deployer -s /bin/bash -G sudo -m deployer
        sudo passwd deployer
        su deployer

Download and run the script.

        yes | sudo apt-get install git-core
        git clone git://github.com/okor/LEMPress.git
        cd LEMPress
        bash build.sh

The `build.sh` script will guide you though the WordPress and LEMPress stack install. When you're done, you'll have a highly optimized WordPress server ready for viral loads.