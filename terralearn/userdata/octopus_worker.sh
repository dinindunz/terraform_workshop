#!/bin/bash
sudo apt-get update
sudo apt-get install unzip
sudo wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
sudo unzip terraform_0.15.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/
sudo terraform --version
sudo apt-get install -y awscli