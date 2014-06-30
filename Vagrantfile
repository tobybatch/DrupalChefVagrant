# -*- mode: ruby -*-
# vi: set ft=ruby ts=2 sw=4 :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty32"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-i386-vagrant-disk1.box"

  # Use NAT'd networking
  # config.vm.network :forwarded_port, guest: 80, host: 8808
  # config.vm.network :forwarded_port, guest: 9000, host: 9000
  # config.vm.network :forwarded_port, guest: 443, host: 4443

  # Enable this to get a private host ony network, so all the ports will be avaiable but only to the hosting machine
  config.vm.network "private_network", ip: "192.168.20.4"

  # This bridges the adapter, the VM will appear as real machine on your network
  # config.vm.network "public_network"

  # Shell bad, chef good!  Put any custom shell config in this file
  # config.vm.provision :shell, :path => "provision.sh"

  config.vm.provider :virtualbox do |vb|
    # Set memory and CPU count
    # This is the default
    # vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2", "--ioapic", "on"]
    #
    # Or we can get clever and assign cpus and ram depenednt on the physical resources
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end
    
    vb.customize ["modifyvm", :id, "--memory", mem]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  # change our mounted folder - only indlude this for development
  # if you are deploying you MUST comment this line out or the 
  # site will deploy to the host machine
  #
  # This is for any OS
  # config.vm.synced_folder "html/", "/var/www/html"
  # Performance it +++ if we can use nfs
  config.vm.synced_folder "html/", "/var/www/html", nfs: true

  # This folder is excluded from the git check in (it's a public
  # repo).  Here we look for id_rsa and id_rsa.pub to install so
  # we can access private repos for deployment
  config.vm.synced_folder "keys/", "/tmp/keys"

  config.vm.provision "chef_solo" do |chef|
    chef.log_level = :warn

    VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('vagrant.json').read)
    chef.run_list = VAGRANT_JSON.delete('run_list')
    chef.json = VAGRANT_JSON

   # Disabled as chef_solo doesnot support ssh_known_hosts
   #  "ssh_known_hosts" => {
   #      "known_hosts" => {
   #          "fqdn" => "github.com",
   #          "rsa" => "github.com,192.30.252.128 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="
   #      }
   #  }

  end

  # The default_site_enabled does not seem to be respected in the apache recipe
  config.vm.define "disble-apache-default" do |web|
    web.vm.provision "shell",
      inline: "a2dissite 000-default.conf"
    web.vm.provision "shell",
      inline: "service apache2 reload", id: "ada"
  end

end
