# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty32"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  # Use NAT'd networking
  config.vm.network :forwarded_port, guest: 80, host: 8808
  # config.vm.network :forwarded_port, guest: 443, host: 4443

  # This bridges the adapter, the VM will appear as real machine on your network
  # config.vm.network "public_network"

  # Shell bad, chef good!  Put any custom shell config in this file
  # config.vm.provision :shell, :path => "provision.sh"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # change our mounted folder 
  config.vm.synced_folder "html/", "/var/www/html"
  
  config.vm.provision "chef_solo" do |chef|
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "git"
    chef.add_recipe "vim"
    chef.add_recipe "apache2"
    chef.add_recipe "mysql::client"
    chef.add_recipe "mysql::server"
    chef.add_recipe "php"
    chef.add_recipe "apache2::mod_php5";
    chef.add_recipe "composer"
    chef.add_recipe "chef-drush"
    # chef.add_recipe "drush"
    # chef.add_recipe "drupal"
  end

end
