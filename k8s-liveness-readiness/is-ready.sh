#!/bin/bash
set -e

# Is NSO started?
source /opt/ncs/current/ncsrc
ncs --wait-started

# Can it service a simple action?
curl -f -X POST -u admin:admin http://localhost:8080/restconf/data/k8s/ready
