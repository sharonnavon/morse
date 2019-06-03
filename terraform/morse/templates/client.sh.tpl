#!/bin/bash

sudo sed -i 's/us-east-1.ec2.//g' /etc/apt/sources.list
sudo apt-get -qq update
sudo apt-get install -yqq python3
sudo wget -O /opt/ip_to_morse_client.py https://raw.githubusercontent.com/sharonnavon/wix/master/terraform/templates/ip_to_morse_client.py
sudo chmod 770 /opt/ip_to_morse_client.py
sudo sed -i 's/host = ""/host = "${elb_morse_dns_name}"/g' /opt/ip_to_morse_client.py
