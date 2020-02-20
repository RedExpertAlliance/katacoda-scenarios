#!/bin/bash

# start Docker Container with OCI 
mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

{
echo '{'
echo  '"actions": ['
echo    '{'
echo      '"actionType": "ONS",'
echo      '"description": "Send an Email Notification after a bucket is created",'
echo      '"isEnabled": true,'
echo      '"topicId": "TopicID"'
echo    '}'
echo  ']'
echo '}'
} > actions.json

{
echo '{'
echo  '"actions": ['
echo    '{'
echo      '"actionType": "FAAS",'
echo      '"description": "Invoke PDF conversion when text file is uploaded to the IN bucket",'
echo      '"isEnabled": true,'
echo      '"functionId": "FunctionID"'
echo    '}'
echo  ']'
echo '}'
} > actionsFunc.json


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


# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

touch /root/allSetInBackground


docker pull fnproject/node:latest

export MY_VAR=jan
