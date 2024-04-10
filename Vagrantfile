# -*- mode: ruby -*-
# vi:set ft=ruby sw=2 ts=2 sts=2:

# Define the number of master and worker nodes
# If this number is changed, remember to update setup-hosts.sh script with the new hosts IP details in /etc/hosts of each VM.
NUM_MASTER_NODE = 1
NUM_WORKER_NODE = 2
NUM_MGMT_NODE = 1

IP_NW = "192.168.0."
MASTER_IP_START = 240
NODE_IP_START = 242
MGMT_IP_START = 239

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false

  # Provision Master Nodes
  (1..NUM_MASTER_NODE).each do |i|
      config.vm.define "kubemaster" do |node|
        # Name shown in the GUI
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubemaster"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kubemaster"
        node.vm.network :public_network, bridge: "Intel(R) Wi-Fi 6 AX201 160MHz", ip: IP_NW + "#{MASTER_IP_START + i}"
       # node.vm.network "forwarded_port", guest: 22, host: "#{2710 + i}"

        node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end

        node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"

        node.vm.provision "copy_public_key", type: "file", source: "ubuntu/vagrant/my_key.pub", destination: "/tmp/my_key.pub"
        node.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/my_key.pub > /home/ubuntu/.ssh/authorized_keys"

      end
  end


  # Provision Worker Nodes
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "kubenode0#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubenode0#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kubenode0#{i}"
        node.vm.network :public_network, bridge: "Intel(R) Wi-Fi 6 AX201 160MHz", ip: IP_NW + "#{NODE_IP_START + i}"
        #        node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"

        node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end

        node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"

        node.vm.provision "copy_public_key", type: "file", source: "ubuntu/vagrant/my_key.pub", destination: "/tmp/my_key.pub"
        node.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/my_key.pub > /home/ubuntu/.ssh/authorized_keys"

    end
  end
  # Provision Management Nodes
  (1..NUM_MGMT_NODE).each do |i|
    config.vm.define "kubemgmt#{i}" do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.name = "kubemgmt#{i}"
            vb.memory = 2048
            vb.cpus = 2
        end
        node.vm.hostname = "kubemgmt#{i}"
        node.vm.network :public_network, bridge: "Intel(R) Wi-Fi 6 AX201 160MHz", ip: IP_NW + "#{MGMT_IP_START + i}"
        #        node.vm.network "forwarded_port", guest: 22, host: "#{2705 + i}"

        node.vm.provision "setup-hosts", :type => "shell", :path => "ubuntu/vagrant/setup-hosts.sh" do |s|
          s.args = ["enp0s8"]
        end

        node.vm.provision "setup-dns", type: "shell", :path => "ubuntu/update-dns.sh"

        node.vm.provision "copy_public_key", type: "file", source: "ubuntu/vagrant/my_key.pub", destination: "/tmp/my_key.pub"
        node.vm.provision  "update_public_key", type: "shell", inline: "cat /tmp/my_key.pub > /home/ubuntu/.ssh/authorized_keys"
        
        node.vm.provision "ansible-setup", type: "shell", :path => "ubuntu/ansible-mgmt.sh"

    end
  end
end
