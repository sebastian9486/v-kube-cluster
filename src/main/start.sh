#!/bin/bash

# load common vars
source ./vars.sh

clear

################################################################################
#    Start monitoring and logging services                                     #
################################################################################

# echo -e "$LOG_INFO Start monitoring and logging services"
#
# echo -e "$LOG_DONE ------------------------------------------------------------------"
# echo -e "$LOG_DONE All monitoring and logging services up and running"
# echo -e "$LOG_DONE ------------------------------------------------------------------"

################################################################################
#    Start vagrant boxes                                                       #
################################################################################

echo -e "$LOG_INFO Startup all vagrant boxes for kubernetes cluster"

cd kube-cluster
vagrant up
cd ..

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE All vagrant boxes up and running"
echo -e "$LOG_DONE ------------------------------------------------------------------"

################################################################################
#    Deploy applications to kubernetes                                         #
################################################################################

echo -e "$LOG_INFO Start application deployments"

./kube-cluster/kubernetes-setup/deploy/dashboard.sh

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE Finished application deployments"
echo -e "$LOG_DONE ------------------------------------------------------------------"
