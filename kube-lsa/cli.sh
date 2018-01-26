#!/bin/sh

UPPER=`kubectl get po -l app=nso-lsa-upper | grep Running | awk '{print $1}'`

kubectl exec -it $UPPER bash 
