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
 2. Do a ```git submodule init && git submodule update```
 3. ```export REMOTE_HOST=1.2.3.4```
 4. ```rsync -a --progress . root@$REMOTE_HOST:/var/chef```
 5. set up key access for root user and make sure those keys are able to clone our private repos
 6. ```ssh root@192.168.33.10 "chef-solo -c /var/chef/cookbooks/solo.rb"```

## More info & Troubleshhoting

See the root project readme: https://github.com/tobybatch/DrupalChefVagrant
