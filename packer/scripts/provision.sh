#!/bin/bash

sudo apt-get -y update
sudo apt-get install -y git git-review python-pip python-dev
sudo easy_install -U pip

curl -sSL https://get.docker.com/ubuntu/ | sudo sh
echo 'DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 -G vagrant"' | sudo tee /etc/default/docker

sudo restart docker
docker version

sudo mkdir -p /opt/stack
sudo chown -R vagrant: /opt/stack
pushd /opt/stack

if [ -d nova-docker ]; then
  pushd nova-docker
  git fetch
  popd
else
  git clone https://git.openstack.org/stackforge/nova-docker.git
fi

if [ -d devstack ]; then
  pushd devstack
  git fetch
  popd
else
  git clone https://git.openstack.org/openstack-dev/devstack.git
fi

for x in */.git ; do
  X=${x%/.git}
  pushd $X &>/dev/null
    git fetch -v &
  popd &>/dev/null
done
wait

pushd /opt/stack/nova-docker
sudo pip install --upgrade .
contrib/devstack/prepare_devstack.sh

pushd /opt/stack/devstack

[ -f localrc ] && rm localrc

cat > local.conf <<EOF
[[local|localrc]]
ADMIN_PASSWORD=password
DATABASE_PASSWORD=\$ADMIN_PASSWORD
RABBIT_PASSWORD=\$ADMIN_PASSWORD
SERVICE_PASSWORD=\$ADMIN_PASSWORD
SERVICE_TOKEN=token
VIRT_DRIVER=novadocker.virt.docker.DockerDriver

DEST=/opt/stack
SERVICE_DIR=\$DEST/status
DATA_DIR=\$DEST/data
LOGFILE=\$DEST/logs/stack.sh.log
LOGDIR=\$DEST/logs

#FIXED_RANGE=10.254.1.0/24
#NETWORK_GATEWAY=10.254.1.1

disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta

#disable_service horizon
#disable_service tempest
#OFFLINE=True

# Introduce glance to docker images
[[post-config|\$GLANCE_API_CONF]]
[DEFAULT]
container_formats=ami,ari,aki,bare,ovf,ova,docker

# Configure nova to use the nova-docker driver
[[post-config|\$NOVA_CONF]]
[DEFAULT]
compute_driver=novadocker.virt.docker.DockerDriver
EOF

./stack.sh

sed -i 's/\#OFFLINE=True/OFFLINE=True/' local.conf

sudo cp /opt/stack/nova-docker/etc/nova/rootwrap.d/docker.filters   /etc/nova/rootwrap.d/

. openrc admin

glance image-list | grep cirros | cut -d\| -f2 | xargs -n1 glance image-delete

popd

sudo dpkg --get-selections | grep -iv mysql > /vagrant/scripts/installed-software
