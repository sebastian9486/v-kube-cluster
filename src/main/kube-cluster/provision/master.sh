#!/bin/bash

echo
echo
echo

#
# kubernetes cluster config
#
echo "[INFO] ----- kubernetes cluster config ----------------------------------"

kubeadm init --pod-network-cidr="192.168.99.0/8" \
    --apiserver-advertise-address="192.168.99.10" \
    --apiserver-cert-extra-sans="192.168.99.10" \
    --node-name "v-k8s-master" > /etc/join_cluster.sh

chmod +x /etc/join_cluster.sh

sysctl net.bridge.bridge-nf-call-iptables=1
echo "[DONE] pod network"

mkdir -p /home/vagrant/.kube
sudo cp -if /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown $(id -u):$(id -g) /home/vagrant/.kube/config
echo "[DONE] set up kubeadm to work from a non root user"

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
echo "[DONE] added network driver"

echo "[DONE] ----- finished kubernetes cluster config -------------------------"
echo


#
# DONE
#
echo
echo
echo "[DONE] ******************************************************************"
echo "[DONE] ***   finished master setup                                    ***"
echo "[DONE] ******************************************************************"
