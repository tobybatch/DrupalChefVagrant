# -*- mode: ruby -*-
# vi: set ft=ruby ts=2 sw=4 :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "digital_ocean"

  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.vm.provider :digital_ocean do |provider|
      provider.client_id = "Vagrant Deployment"
      provider.api_key = "78b1010b79abcf89e461e4d533dab9dcab056fc3988bb99e663fe61a251f7b2a"
      provider.image = "Ubuntu 14.04 x64"
      provider.region = "Amsterdam 2"
  end

  config.vm.provision "chef_solo" do |chef|
    chef.log_level = :warn

    VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('vagrant.json').read)
    chef.run_list = VAGRANT_JSON.delete('run_list')
    chef.json = VAGRANT_JSON
  end

end
