# Python Dev Community Ansible Deployment Scripts

The Python Developers slack community has a number of projects that we
have started. This repository contains our deployment scripts :tada:

Interested in becoming a member? Get your invite here: http://pythondevelopers.herokuapp.com/

## Get Started

**There are some assumptions that are made you should be aware of before using this project.**
    
- In the root of your home directory you should have a folder named `.environments` that all your virtual environments are located.
- This project is in the same folder as the application you are trying to deploy.
- If you need to change any of these things you need to alter the variables in `pythondev-ansible/group_vars/all.yml`

### Prepare the Ansible deployment

1. Create a virtualenv and install the requirements.

    $ pip install -r requirements.txt


### Prepare Ubuntu Server 16.04

> Note: 
    The following is for deploying to Ubuntu Server 16.04 which does not have Python 2 installed

Install Python 2 on the server using the raw command

    $ ansible <host_pattern> -i environments/<app-name>/<env> -m raw -a "apt-get install -y python-simplejson"
    
**Example:**
    
    ansible sirbot -i environments/sirbot/prod -m raw -a "apt-get install -y python-simplejson"
    
-OR-

Run the the `prepare_ubuntu16.04` playbook for the server

    $ ansible-playbook -i environments/<app>/<env> prepare_ubuntu16.04.yml`


### Run the deployment for the specific app you want to deploy

> Note:
    You will need to already have your ssh keys included in our provisioning tasks.
    If you do not then you will need to have an admin run the `secure_server.yml` playbook.

Run the full deployment.

    $ ansible-playbook -i environments/sirbot/prod sirbot.yml --ask-vault-pass

If you have done a full deployment and only want to deploy the app you can add the `--skip-tags configuration` option

    $ ansible-playbook -i environments/sirbot/prod sirbot.yml --skip-tags configuration
