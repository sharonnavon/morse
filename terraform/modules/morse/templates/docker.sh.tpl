#!/usr/bin/env bash

# Install Docker-ce
sudo sed -i 's/us-east-1.ec2.//g' /etc/apt/sources.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt -qq update &> /dev/null
sudo apt install -yqq apt-transport-https ca-certificates curl gnupg2 software-properties-common docker-ce &> /dev/null


# Build & run the morse container
sudo mkdir /opt/docker
cd /opt/docker
sudo wget https://raw.githubusercontent.com/sharonnavon/morse/master/terraform/modules/morse/templates/Dockerfile
sudo wget -O /opt/docker/ip_to_morse_service.py https://raw.githubusercontent.com/sharonnavon/morse/master/terraform/modules/morse/templates/ip_to_morse_service.py
sudo docker build -t morse_service .
sudo docker run -d --name=morse_service -v /opt/docker/ip_to_morse_service.py:/opt/ip_to_morse_service.py -p 9999:9999 morse_service
