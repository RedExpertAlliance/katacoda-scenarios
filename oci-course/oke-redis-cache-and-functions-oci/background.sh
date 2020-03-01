#!/bin/bash

mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

wget https://raw.githubusercontent.com/RedExpertAlliance/katacoda-scenarios/master/oci-course/oke-redis-cache-and-functions-oci/installCLI.sh
chmod +777 installCLI.sh


# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults


# docker pull stephenpearson/oci-cli:latest
#docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci  stephenpearson/oci-cli:latest 
#setup config
#
# add this line to ~/.profile
# oci() { docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci stephenpearson/oci-cli:latest "$@"; }


# install kubectl
sudo snap install kubectl --classic

touch /root/allSetInBackground

export MY_VAR=jan