# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.define "master" do |master|
    config.vm.hostname = "master"
    master.vm.box = "precise64"
    master.vm.network :private_network, ip: "192.168.33.10"
    config.vm.synced_folder "salt/roots/", "/srv/"
    config.vm.provision :salt do |salt|
      salt.install_master = true
      salt.no_minion = true
      salt.seed_master = {minion:"salt/roots/minion.pub"}
  end
  end  
  config.vm.define "minion" do |minion|
    minion.vm.box = "precise64"
    config.vm.hostname = "minion"
    minion.vm.network :private_network, ip: "192.168.33.11"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.provision :salt do |salt|
      salt.install_master = false
      salt.minion_config = "salt/roots/minion"
      salt.run_highstate = true
      salt.minion_key = "salt/roots/minion.pem"
      salt.minion_pub = "salt/roots/minion.pub"
  end
  end
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
end
