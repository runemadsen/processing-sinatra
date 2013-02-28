Vagrant::Config.run do |config|

  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"

  config.vm.forward_port 3000, 3000
  
  config.vm.provision :puppet do |puppet|
    puppet.module_path = "puppet/modules"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "development.pp"
  end

end