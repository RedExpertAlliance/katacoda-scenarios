#!/bin/bash

# start Docker Container with OCI 
mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

wget https://raw.githubusercontent.com/RedExpertAlliance/katacoda-scenarios/master/oci-course/infrastructure-events-notifications-streaming-oci/installCLI.sh --no-check-certificate
wget https://raw.githubusercontent.com/RedExpertAlliance/katacoda-scenarios/master/oci-course/infrastructure-events-notifications-streaming-oci/actions.json --no-check-certificate
wget https://raw.githubusercontent.com/RedExpertAlliance/katacoda-scenarios/master/oci-course/infrastructure-events-notifications-streaming-oci/actionsFunc.json --no-check-certificate

chmod +777 installCLI.sh

# Install the OCI CLI in silent mode with default settings
curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh > install-oci-cli.sh
chmod +777 install-oci-cli.sh
./install-oci-cli.sh --accept-all-defaults


#install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

# docker pull stephenpearson/oci-cli:latest
#docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci  stephenpearson/oci-cli:latest 
#setup config
#
# add this line to ~/.profile
# oci() { docker run --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci stephenpearson/oci-cli:latest "$@"; }

touch /root/allSetInBackground

docker pull fnproject/node:latest
