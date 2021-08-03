#!/bin/bash

application_file_path="/vagrant/installed-application.md"

sudo apt update
while :
do
  sudo apt-get -y install \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg-agent \
       software-properties-common

  retcode=$?
  if [ $retcode -eq 0 ]; then
    break
  fi
  echo "sleep 5s ..."
  sleep 5
done

# add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add docker repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt-get update
while :
do
  sudo apt-get -y install docker-ce docker-ce-cli containerd.io
  retcode=$?
  if [ $retcode -eq 0 ]; then
    break
  fi
  echo "sleep 5s ..."
  sleep 5
done

# add vagrant user to docker group
sudo groupadd docker
sudo gpasswd -a vagrant docker

# get docker version
DOCKER_VERSION=$(sudo docker version --format '{{.Server.Version}}')
echo "# Installed application "  > $application_file_path
echo "***                     " >> $application_file_path
echo "> docker $DOCKER_VERSION" >> $application_file_path
