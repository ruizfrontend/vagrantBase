# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"

    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    # config.vm.network "forwarded_port", guest: 80, host: 8080

    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network "private_network", ip: "192.168.33.10"

    # Use NFS for the shared folder
    config.vm.synced_folder "./files", "/vagrant", owner: "vagrant", group: "www-data", mount_options: ["dmode=775,fmode=664"]


    config.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM:
        vb.memory = "2048"
        vb.name = "local.foreman.com"

        # Set server cpus
        vb.customize ["modifyvm", :id, "--cpus", "2"]

        # Set server memory
        vb.customize ["modifyvm", :id, "--memory", "2048"]

        vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
    end

    config.vm.provision :shell, :path => "install.sh"

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
end