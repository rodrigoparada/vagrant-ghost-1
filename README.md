# Vagrant Server for Ghost Development

A basic Ghost setup for testing and theme development utilizing a Vagrant VM (default: Ubuntu 12.04 Precise Pangolin 64bit) with shell-provisioning.

Basic Information:
* [Vagrant - Development environments made easy](http://www.vagrantup.com)
* [Ghost Blogging Platform](https://ghost.org)

## Requirements
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (tested on 4.3.10)
* [Vagrant](http://docs.vagrantup.com/v2/installation/index.html) (tested on 1.5.4)

## Usage
Create a project directory:
```bash
mkdir ghost-vm
cd ghost-vm
```
Clone this repository:
```bash
git clone https://github.com/hanneshauer/vagrant-ghost
```
Fire up Vagrant:
```bash
cd vagrant
vagrant up
```
Once the VM has been booted, SSH into it and start the node-server:
```bash
vagrant ssh
startghost
```
Your Ghost blog should now be available at 'localhost:1234'.

The setup provides a pre-filled database. You can login with the mail address 'test@test.com' and password 'testest'.

## Theme development
The Ghost themes directory will be moved from inside the installation folder to the main directory. Put your theme files in there instead of directly into 'ghost-latest/content/themes'.

If you want to use version control for theme development, add your code as a submodule into the 'themes'-directory in the main folder.

## Ghost development
The script will automatically download the latest stable version of Ghost. If you want to use another version or create pull requests for any changes you make, put the code into the folder 'ghost-latest' in the main directory as a submodule before you first start and provision with Vagrant. (If you want to use another name for the directory (e.g. 'ghost-development'), change the variable GHOST_DIR_NAME in 'vagrant/shell/install-ghost.sh' accordingly.)

## Further information and customization
### Vagrantfile
The Vagrantfile is pretty basic. It uses the Ubuntu 12.04 64bit-Box provided by Vagrant developer hashicorp ([hashicorp/precise64](https://vagrantcloud.com/hashicorp/precise64)), but you should be able to replace it with any other Precise Pangolin-Box.

By default, the VM is available at 'localhost:1234'. If you want to use another port, simply change the variable HOSTPORT on top of the Vagrantfile; you can also use a dedicated IP by uncommenting the 'config.vm.network "private_network"' line, but since you'll have to add the port used by the node server (Default: 2368) anyways I'd recommend simply using localhost.

### install-tools.sh
* Installs curl and unzip for downloading Ghost

### install-nodejs.sh
* Downloads up-to-date version of node.js and npm
Ubuntu 12.04 by default has an outdated version of node in its repositories (see [node Wiki](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager)), thus an additional repository needs to be added to get an up-to-date version.

### install-ghost.sh
* Downloads and sets up the latest Ghost version in the folder 'ghost-latest'
* Moves and symlinks 'themes'-directory from inside the Ghost installation folder to the main project directory for easier access
* Opens up the node server to connections from outside the VM
* Adds the alias 'startghost' as a shortcut to starting the node server for the SSH-user