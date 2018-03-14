# hyperv-minikube
`supreme-lamp` was the suggested name which makes sense, even though I don't think the image comes with Apache or MySQL.

# What it is

Kubernetes is the new sexy right; but the the people doing sexy things don't love Windows. Rather than trying to do all the stuff to make minikube etc run on Windows; we can, with nested virtualisation in Windows 10, bootstrap a linux environment that contains all the things that you need to start mucking about with Kubernetes.

So, we install
- python 2.7 along with python-pip
- Add the repos for docker + virtualbox
- Install docker-ce + virtualbox 5.2
- Grab the minikube/kubectl/kops binaries

# Getting Started
- copy env.yml.template -> env.yml
- edit env.yml to your satisfaction; you can use it override the settings in defaults.yml
- edit env.yml so that your ssh config is in the game (or comment out the appropriate lines).
- vagrant up.

# TODO
- Probably want to mount some local directories via CIFS
- Check why the `enable_virtualization_extensions` doesn't always seem to do what the vagrant documentation says it should.
- Find an Ubuntu LTS image that doesn't need quite so many updates; initial provisioning takes far too long.
- Using differencing disks is probably quicker to spin up the virtual machine.