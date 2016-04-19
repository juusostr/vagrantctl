#!/bin/bash

env_name=$1

env_folder=./vagrant/envs

if [ ! -d $env_folder/$env_name ]; then
    mkdir -p $env_folder/$env_name
    cp ./vagrant/templates/Vagrantfile.template $env_folder/$env_name/Vagrantfile
    cp ./vagrant/templates/vagrant_vms.yml.template $env_folder/$env_name/vagrant_vms.yml
else
    echo "Environment $env_name already exists."
fi
