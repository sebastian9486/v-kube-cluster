#!/bin/bash

# load common vars
source ./vars.sh

clear

echo -e "$LOG_INFO ------------------------------------------------------------------"
echo -e "$LOG_INFO Start Vagrant Boxes"
echo -e "$LOG_INFO ------------------------------------------------------------------"

cd kube-cluster
vagrant up
cd ..

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE All Vagrant Boxes up and running"
echo -e "$LOG_DONE ------------------------------------------------------------------"
