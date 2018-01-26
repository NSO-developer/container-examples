#!/bin/sh

LOWER1=`kubectl get po -l app=nso-lsa-lower-1 | grep Running | awk '{print $1}'`
kubectl exec -it $LOWER1 bash << EOF
source /root/nso/ncsrc
ncs_cli -u admin
configure
set device device ex0 address nso-lsa-netsim
set device device ex1 address nso-lsa-netsim
set device device ex2 address nso-lsa-netsim
commit
run show device list
request devices fetch-ssh-host-keys
request devices sync-from
EOF

LOWER2=`kubectl get po -l app=nso-lsa-lower-2 | grep Running | awk '{print $1}'`
kubectl exec -it $LOWER2 bash << EOF
source /root/nso/ncsrc
ncs_cli -u admin
configure
set device device ex3 address nso-lsa-netsim
set device device ex4 address nso-lsa-netsim
set device device ex5 address nso-lsa-netsim
commit
run show device list
request devices fetch-ssh-host-keys
request devices sync-from
EOF

UPPER=`kubectl get po -l app=nso-lsa-upper | grep Running | awk '{print $1}'`

kubectl exec -it $UPPER bash << EOF
source /root/nso/ncsrc
ncs_cli -u admin
configure
set device device lower-nso-1 address nso-lsa-lower-1
set device device lower-nso-2 address nso-lsa-lower-2
commit
run show device list
request devices fetch-ssh-host-keys
request devices sync-from
EOF

