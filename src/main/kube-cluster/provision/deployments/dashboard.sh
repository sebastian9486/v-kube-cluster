#!/bin/bash

echo

#
# deploy applications
#
echo "[INFO] ----- application deployment: dashboard --------------------------"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.1.0/aio/deploy/recommended.yaml
echo "[DONE] deployed dashboard"

kubectl proxy
echo "[DONE] Created a secure channel to kubernetes cluster to access dashboard from local workstation"



echo "[DONE] ----- finished application deployment: dashboard -----------------"
echo
