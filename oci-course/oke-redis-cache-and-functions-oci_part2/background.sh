#!/bin/bash

wget https://raw.githubusercontent.com/RedExpertAlliance/katacoda-scenarios/master/oci-course/oke-redis-cache-and-functions-oci_part1/installCLI.sh
chmod +777 installCLI.sh

mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

mkdir /root/keys

# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults

# install kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

touch /root/allSetInBackground

export MY_VAR=jan
export PATH=/root/bin/:$PATH