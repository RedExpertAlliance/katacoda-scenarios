#!/bin/bash

mkdir ~/.oci
touch  ~/.oci/config
touch  ~/.oci/oci_api_key.pem

# install Project Fn CLI
curl -LSs https://raw.githubusercontent.com/fnproject/cli/master/install | sh

docker pull fnproject/node:latest

