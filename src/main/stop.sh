#!/bin/bash

# load common vars
source ./vars.sh

echo -e "$LOG_INFO ------------------------------------------------------------------"
echo -e "$LOG_INFO Shutting down Vagrant Boxes"
echo -e "$LOG_INFO ------------------------------------------------------------------"

cd kube-cluster
vagrant halt
cd ..

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE All Vagrant Boxes are shut down"
echo -e "$LOG_DONE ------------------------------------------------------------------"
