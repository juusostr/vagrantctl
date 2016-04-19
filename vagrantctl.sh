#!/bin/bash

# Constants

ENV_DIR="./vagrant/envs/$2"

# Methods

run_command() {
    if [ ! -d $ENV_DIR ]; then
        echo "No environment $ENV_DIR found."
    else
        cd $ENV_DIR && $@
        cd -
    fi
}

prompt_for_okay() {
    while true; do
        read -p "Running command $@. Are you sure you want to do this? [Y/N] " yn
        case $yn in
            [Yy]* )
                echo "Okay. Running."
                $($@)
                break
            ;;
            [Nn]* )
                echo "Not running. Exiting."
                exit
            ;;
            * )
                echo "Please answer yes or no."
            ;;
        esac
    done
}

print_usage() {
echo "Usage: ./vagrantctl.sh <option> <environment>"
echo
echo "up - Starts the VMs in the environment (vagrant up)"
echo "halt - Stops the VMs in the environment (vagrant halt)"
echo "init - Initializes the environment."
echo "status - Shows the status of the VMs in the environment."
echo "global-status - Same as vagrant global-status"
echo "destroy - Destroys the VMs in the environment. NOTE: Does not destroy the env directory."
echo "complete-destroy - Destroys the whole environment (VMs AND directory). Use carefully."
echo "help - Prints this usage message"
}

# Main

key="$1"

case $key in
    init)
        echo "Initializing new environment $2"
        ./vagrant/create_new_vagrant_env.sh "$2"
        run_command $EDITOR vagrant_vms.yml
    ;;
    edit)
        run_command $EDITOR vagrant_vms.yml
    ;;
    up)
        run_command vagrant up
    ;;
    status)
        run_command vagrant status
    ;;
    global-status)
        vagrant global-status
    ;;
    halt)
        run_command vagrant halt
    ;;
    destroy)
        run_command vagrant destroy
    ;;
    complete-destroy)
        run_command vagrant destroy
        prompt_for_okay "rm -r $ENV_DIR"
    ;;
    help)
        print_usage
    ;;
    *)
        print_usage
    ;;
esac
