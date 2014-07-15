LymebayDeploy 
=============

## Sub Modules

You must ```submodule init && submodule update```

## Quick start

 1. Change directory into this folder
 1. Do a ```git submodule init && git submodule update```
 1. ```export REMOTE_HOST=1.2.3.4```
 1. ```ssh root@$REMOTE_HOST "apt-get -y update && apt-get -y install ruby1.9.1-full make && gem install chef ruby-shadow --no-ri --no-rdoc"``` **Add these to a recipie**
 1. ```rsync -a --exclude=html --exclude=keys --exclude=nbproject --progress . root@$REMOTE_HOST:/var/chef```
 1. ```ssh root@$REMOTE_HOST "chef-solo -c /var/chef/cookbooks/solo.rb"```
 1. Copy your deb file onto the server and install it
 1. Disable the current default site and enable the new site in apache
  
### Post install

In the wild, you will need to:

 1. Install a valid server certifiacte, see /etc/pound/* for details
 2. Fire wall off port 80 so that all traffic has to go via pound/ssl
 3. Update the /var/www/html/*/sites/default/settings.php to set the base url to use https, else the css and javascript will try to serve over http

## Troubleshhoting

 1. Have you cloned the submodules?

## What does this cookbook set do?

It will take an Ubuntu 14.04 base server install and install a LAMP stack on it ready for Drupal.  It will also install varnish and pound and wire them together so that port 443 forward (via varnish) into 80 on the apache.

## What it doesn't do

 1. See the post install docs above
