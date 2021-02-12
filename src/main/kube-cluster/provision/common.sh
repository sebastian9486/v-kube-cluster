#!/bin/bash

# see https://developers.caffeina.com/a-kubernetes-cluster-on-virtualbox-20d64666a678

echo
echo
echo


#
# docker
#
echo "[INFO] ----- start docker setup -----------------------------------------"

dockerVersion="5:19.03.15~3-0~ubuntu-focal"

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - # Add Docker’s official GPG key:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" # Setup apt repo

sudo apt-get update
sudo apt-get install -y docker-ce=$dockerVersion docker-ce-cli=$dockerVersion containerd.io

sudo usermod -aG docker vagrant

echo "[DONE] ----- finished docker setup --------------------------------------"
echo



#
# kubernetes
#
echo "[INFO] ----- start kubeadm, kubectl and kubelet setup -------------------"

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


echo "[DONE] ----- finished kubeadm, kubectl and kubelet setup ----------------"
echo



#
# additional config
#
echo "[INFO] ----- additional config ------------------------------------------"

swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab # keep swap off after reboot
echo "[DONE] Turned of swap"

sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
echo "[DONE] set up password less ssh between guest VMs"

# Kubernetes and Docker must have the same cgroup
sed -i "s/\$KUBELET_EXTRA_ARGS/\$KUBELET_EXTRA_ARGS\ --cgroup-driver=systemd/g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
cat <<EOF >/etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
echo "[DONE] Set cgroup driver to 'systemd' for kubernetes and docker"

systemctl daemon-reload
systemctl restart kubelet
systemctl restart docker
echo "[DONE] Restartet docker and kubernetes"

echo "[DONE] ----- finished additional config ---------------------------------"
echo


#
# DONE
#
echo
echo
echo "[DONE] ******************************************************************"
echo "[DONE] ***   finished common setup                                    ***"
echo "[DONE] ******************************************************************"
