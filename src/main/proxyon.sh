#!/bin/bash

# load common vars
source ./vars.sh

echo -e "$LOG_INFO ------------------------------------------------------------------"
echo -e "$LOG_INFO Start kubectl proxy (not running in background !!)"
echo -e "$LOG_INFO ------------------------------------------------------------------"

cd kube-cluster
vagrant ssh v-k8s-master -c "kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'"
cd ..
