require 'yaml'
dir = File.dirname(File.expand_path(__FILE__))
settings = YAML::load_file("#{dir}/defaults.yml")
if File.exist?("#{dir}/env.yml")
    env_settings = YAML::load_file("#{dir}/env.yml")
    settings.merge!(env_settings)
end

Vagrant.configure(2) do |config|
  config.vm.box = "kmm/ubuntu-xenial64"
  config.vm.provider "hyperv"

  config.vm.provider "hyperv" do |hyperv|

# PS> Set-VMProcessor -VMName MachineName -ExposeVirtualizationExtensions $true
# Need to enable the VT-X nested extensions, perhaps this doesn't do what I think it does;
# as I do get complaints about VT-X not being enabled; when running virtualbox...

    hyperv.enable_virtualization_extensions = "true"
    hyperv.vmname = settings["vm"]["name"]
    hyperv.mac = settings["vm"]["mac"]
    # You're running minikube etc... You probaby want to edit defaults.yaml.
    hyperv.memory = settings["vm"]["memory"]
    hyperv.cpus = settings["vm"]["cpu"]
  end

  config.vm.synced_folder ".", "/home/vagrant/sync", disabled: true

  config.vm.provision "file", source: settings["ssh"]["keyfile"], destination: "$HOME/.ssh/id_rsa"
  config.vm.provision "file", source: settings["ssh"]["config"], destination: "$HOME/.ssh/config"
  config.vm.provision "file", source: settings["ssh"]["known_hosts"], destination: "$HOME/.ssh/known_hosts"
  config.vm.provision "shell", name: ".ssh-permissions", inline: "chmod -R go-rwx .ssh"

  config.vm.provision "shell", path: "provision.sh", name: "Installing all the stuffs..."
end
