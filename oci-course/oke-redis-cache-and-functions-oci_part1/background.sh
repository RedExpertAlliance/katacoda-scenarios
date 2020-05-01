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
sudo snap install kubectl --classic

touch /root/allSetInBackground

export MY_VAR=jan