#!/bin/bash

sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf

service systemd-resolved restart

sudo su - ubuntu
sudo apt update
sudo apt install -y git
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible-galaxy collection install ansible.posix
exit