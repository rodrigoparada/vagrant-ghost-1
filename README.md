# Vagrant Server for Ghost Development

A basic Ghost setup for testing and theme development utilizing a Vagrant VM (default: Ubuntu 12.04 Precise Pangolin 64bit) with shell-provisioning.

Basic Information:
* Vagrant
* Ghost Blogging Platform

## Dependencies
* VirtualBox (tested on 4.3.10)
* Vagrant (tested on 1.5.4)

## Usage
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

## Further information and customization
### Vagrantfile
The Vagrantfile is pretty basic. It uses the Ubuntu 12.04 64bit-Box provided by Vagrant developer hashicorp ([hashicorp/precise64](https://vagrantcloud.com/hashicorp/precise64)), but you should be able to replace it with any other Precise Pangolin-Box.
By default, the VM is available at 'localhost:1234'. If you want to use another port, simply change the variable HOSTPORT on top of the Vagrantfile; you can also use a dedicated IP by uncommenting the 'config.vm.network "private_network"' line, but since you'll have to add the port used by the node server (Default: 2368) anyways I'd recommend simply using localhost.

### install-tools.sh
This shell provisioning script simply installs curl and unzip that are neede for downloading the latest Ghost version.

### install-nodejs.sh
Ubuntu 12.04 by default has an outdated version of node in its repositories (see [node Wiki](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager)), thus an additional repository needs to be added to get an up-to-date version.

### install-ghost.sh
This script will download the latest Ghost version to the folder "ghost-latest" in the directory you cloned this repository if it doesn't exist; thus you can safely delete the Vagrant-created VM ('vagrant destroy') and still keep your Ghost installation.

In order to make theme development easier, the script moves the "themes"-directory from inside the Ghost-folders to the main directory and symlinks it.
If you want to put your theme under version control as well, you can simply add it as a git submodule.

In the default configuration, the node server running Ghost will only listen to connections coming from the local machine - in this case the VM - and isn't available from the host system even though the ports are being forwarded. The script simply replaces all occurences of '127.0.0.1' with '0.0.0.0', opening up the server to requests from the host machine.

The script also adds the alias 'startghost' for the SSH-user to allow for easy launch of the node server.