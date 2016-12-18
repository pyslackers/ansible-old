# Python Dev Community Ansible Deployment Scripts

The Python Developers slack community has a number of projects that we
have started. This repository contains our deployment scripts :tada:

Interested in becoming a member? Get your invite here: http://pythondevelopers.herokuapp.com/

## Get Started

### Prepare Ubuntu Server 16.04

> The following is for deploying to Ubuntu Server 16.04 which does not have Python 2 installed

Install Python 2 on the server using the raw command

    $ ansible <host_pattern> -i <inventory> -m raw -a "apt-get install -y python-simplejson"
    
**Example:**
    
    $ ansible sirbot -i <inventory> -m raw -a "apt-get install -y python-simplejson"
    
-OR-

Run the `prepare_ubuntu16.04` playbook for the server

    $ ansible-playbook -i <inventory> prepare_ubuntu16.04.yml

### Provisioning

> The following is for securing your server. If you are deploying the app on a new server.
    
    $ ansible-playbook -i <inventory> provisioning.yml

### Run the deployment for the specific app you want to deploy

> You will need to already have your ssh keys included in our provisioning tasks.
  If you do not then you will need to have an admin run the `provisioning.yml` playbook.

> Before deploying a new app read the app configuration section

Run the deployment.

    $ ansible-playbook -i <inventory> deploy.yml --tags <app>

## Configuration

### Provisioning

#### Required variables

* `ssh_keys`: Path to your ssh authorized_keys file
    
### Sirbot

To run this playbook the host must be in the `sirbot` group.

#### Required variables

* `sirbot_token`: Your slack token
* `sirbot_name`: Name of the bot
* `sirbot_id`: ID of the bot

#### Optionnal variables:

* `port`: Port for sirbot. Default is 8080

* `force_build`: Force the build of a new package
* `local_deb`: Path to the local `sirbot.deb` file to deploy
* `local_run`: Path to the local `run.py` file to deploy

#### How to create a `sirbot.deb` file

1. Install the `debhelper` and `dh-virtualenv` packages

        $ apt-get install debhelper dh-virtualenv

2. Install the `make-deb` python module

        $ pip install make-deb
    
3. Configure the package

        $ make-deb
    
4. Build the package

    > Make sure the package is being build with minimum a python3.5 executable

        $ export VIRTUALENV_PYTHON=/usr/bin/python3.5 
        $ dpkg-buildpackage -us -uc
        
5. (Optional) Install the package

        $ dpkg -i sirbot_<version>_amd64.deb
    
    
    

