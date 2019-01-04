#!/bin/sh
curl -f -X POST -u admin:admin http://localhost:8080/restconf/data/k8s/alive
