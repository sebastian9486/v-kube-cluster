#!/bin/bash

echo
echo
echo

echo "[INFO] ----- join kubernetes cluster ------------------------------------"

# scp [OPTION] [user@]SRC_HOST:]file1 [user@]DEST_HOST:]file2
scp vagrant@192.168.99.10:/etc/join_cluster.sh /etc/join_cluster.sh
chmod +x /etc/join_cluster.sh
echo "[DONE] obtained join_cluster.sh from master node"

sh ./join_cluster.sh
echo "[DONE] Joined kubernetes cluster"
echo


#
# DONE
#
echo
echo
echo "[DONE] ******************************************************************"
echo "[DONE] ***   finished worker node setup                               ***"
echo "[DONE] ******************************************************************"
