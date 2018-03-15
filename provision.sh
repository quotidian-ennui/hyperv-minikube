#!/bin/bash

# Stop apt-Daily / apt-daily.timer
sudo systemctl stop apt-daily
sudo systemctl stop apt-daily.timer
sudo systemctl disable apt-daily
sudo systemctl disable apt-daily.timer
sudo apt-get -y remove unattended-upgrades

# Get the latest updates.....
sudo apt-get -qq -y update
sudo apt-get -qq -y install python2.7 python-pip  apt-transport-https ca-certificates software-properties-common figlet
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq -y dist-upgrade
sudo apt-get -qq -y autoremove

# Add docker + virtualbox
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
wget -q https://download.docker.com/linux/ubuntu/gpg -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get -qq -y update
sudo apt-get -qq -y install docker-ce virtualbox-5.2
sudo apt-get -qq -y clean

# Well; kmm defaults to Vienna...
sudo timedatectl set-timezone "Europe/London"


# Get minikube etc.
wget -q -O minikube https://storage.googleapis.com/minikube/releases/$(curl -s https://api.github.com/repos/kubernetes/minikube/releases/latest | grep tag_name | cut -d '"' -f 4)/minikube-linux-amd64 && \
    chmod +x minikube && \
    sudo mv minikube /usr/local/bin/
wget -q -O kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin
wget -q -O kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 && \
    chmod +x kops && \
    sudo mv kops /usr/local/bin

figlet NOTE
echo "If nested virtualisation doesn't work; then you need to enable it manually."
echo "Do a vagrant halt and then something like (from powershell)"
echo 'Set-VMProcessor -VMName "machinename" -ExposeVirtualizationExtensions $true'