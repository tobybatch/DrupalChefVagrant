LymebayDeploy 
=============

## Sub Modules

You must ```submodule init && submodule update```

## Quick start

 1. Change directory into this folder
 1. Do a ```git submodule init && git submodule update```
 1. Copy/link your keys for git hub into the keys folder.  These will be installed onto the VM so don't use ones with passwords
 1. Run ```vagrant up```

This will create a vanilla fudge site in a VM. The drupal you created will be available on http://localhost:8808, the files for that site are in ./html/drupal

## Deploying

 1. clone this repo
 1. Do a ```git submodule init && git submodule update```
 1. ```export REMOTE_HOST=1.2.3.4```
 1. ```ssh root@$REMOTE_HOST "apt-get -y update && apt-get -y install ruby1.9.1-full make && gem install chef ruby-shadow --no-ri --no-rdoc"``` **Add these to a recipie**
 1. ```rsync -a --exclude=html --exclude=keys --exclude=nbproject --progress . root@$REMOTE_HOST:/var/chef```
 1. <del>set up key access for root user and make sure those keys are able to clone our private repos</del>
 1. ```ssh root@$REMOTE_HOST "chef-solo -c /var/chef/cookbooks/solo.rb"```
 1. Copy your deb file onto the server and install it
 1. Disable the curretn site and enable the new site in apache

## Troubleshhoting

 1. Have you cloned the submodules?

## Customising

It's all in the Vagrant file...

## Updating your site without a full rebuild

The command used to create your site is stored in /var/tmp/cmd, so ```cat /var/tmp/cmd,``` will show you the command.  Because of keys you'll need to run it as root:

    sudo su - -c `cat /var/tmp/cmd`

