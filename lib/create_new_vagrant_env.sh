#!/bin/bash

env_name=$1
env_folder=./envs
template_folder=./templates

if [ ! -d $env_folder/$env_name ]; then
    mkdir -p $env_folder/$env_name
    cp $template_folder/Vagrantfile.template $env_folder/$env_name/Vagrantfile
    cp $template_folder/vagrant_vms.yml.template $env_folder/$env_name/vagrant_vms.yml
else
    echo "Environment $env_name already exists."
fi
