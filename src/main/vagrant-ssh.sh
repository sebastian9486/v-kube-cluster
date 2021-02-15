#!/bin/bash

#
# param: hostname of vagrant box
#

cd kube-cluster
vagrant ssh $1
cd ..
