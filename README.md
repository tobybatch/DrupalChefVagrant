DrupalChefVagrant
=================

## Sub Modules

You must ```submodule init && submodule update```

## Quick start

 1. Change directory into this folder
 1. Copy/link your keys for git hub into the keys folder.  These will be installed onto the VM so don't use ones with passwords
 1. Run ```vagrant up```

This will create a vanilla fudge site in a VM. The drupal you created will be available on http://localhost:8808, the files for that site are in ./html/drupal

## Troubleshhoting

 1. Have you cloned the submodules?
 1. Have you linked/copied keys into the keys folder
 1. Have you added your pyblic key to the NT Deploy user (nt-deploy)

## Customising

It's all in the Vagrant file...

## Updating your site without a full rebuild

The command used to create your site is stored in /var/tmp/cmd, so ```cat /var/tmp/cmd,``` will show you the command.  Because of keys you'll need to run it as root:

    sudo su - -c `cat /var/tmp/cmd`

