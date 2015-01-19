#!/bin/sh


DIR=$(cd $(dirname $0); pwd)
echo --- > group_vars/all
echo directory_name: $DIR >> group_vars/all

ansible-playbook -i hosts main.yml --ask-sudo-pass -vvv
