#!/bin/bash

# load common vars
source ../../vars.sh

echo -e "$LOG_INFO Start deployment of application: dashboard"
echo -e "$LOG_INFO Start deployment"
vagrant ssh v-k8s-master -c 'kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml'

vagrant ssh v-k8s-master -c 'cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF'
echo -e "$LOG_DONE Created service account"

vagrant ssh v-k8s-master -c 'cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF'
echo -e "$LOG_DONE Created service account"


echo -e "$LOG_INFO ***   BEARER TOKEN   *********************************************"
echo
vagrant ssh v-k8s-master -c 'kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"'
echo
echo -e "$LOG_INFO ******************************************************************"

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE Deployed application: dashboard"
echo -e "$LOG_DONE ------------------------------------------------------------------"

vagrant ssh v-k8s-master -c 'kubectl proxy &'
echo -e "$LOG_DONE Started kube proxy on v-kube-master machine"
echo -e "$LOG_INFO http://192.168.50.10:8001/ui"
echo -e "$LOG_INFO http://192.168.50.10:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"
