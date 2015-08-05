#!/bin/bash -eux

sudo apt-get install -y ssh openssh-server
sudo update-rc.d ssh defaults

echo "UseDNS no" >> /etc/ssh/sshd_config
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
