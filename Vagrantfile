# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "flyingcircus/nixos-14.12-i686"
  config.vm.provider "virtualbox" do |v|
      v.memory = 2048
  end

  config.vm.network "private_network", ip: "192.168.50.4"

  config.vm.provision :nixos, :verbose => true, :path => "provision.nix"

end
