# Running NSO in Docker/Kubernetes

This document aims to give some insight and ideas around running NSO in a Docker containers. 

NSO is inherently a stateful application with a built-in database, so special attention has to be paid to have relevant parts of the container persisted.

**NOTE** If you have feedback on this document, please contact me.

## NSO Structure
Please note that the name and exact directories can vary, but these are the most common names.

### packages
The packages loaded by NSO are (typically) stored here. This directory is only read by NSO and doesn't need to be persisted.

### ncs-cdb
This is where NSO stores its database, CDB, and it has to be persisted.

### state
Loaded packages as well as other NSO state is stored here, has to be persisted.

### logs
The recommended way of logging in containers is to write to stdout. NSO can be run in foreground mode to accomplish this. 

In this case, logging to file can be disabled, and the logs directory can be ephemeral.

## Structure of an NSO Image
When building the NSO container, you can choose to include or exclude the packages in the container and you get somewhat different behavior. 

If the packages are excluded from the container, upgrading the container version will just upgrade NSO to the newer version. Please note that if upgrading between major versions of NSO, the packages have to be recompiled.

If the packages are included in the container, it's possible to upgrade NSO and the packages in one go. If NSO has been updated to a new major version, NSO have to be started with "--with-package reload". The reason is that the persisted state directory contains the packages compiled with the previous version of NSO.

## Java Heap
I've noticed some startup speed improvements by setting the Java initial heap allocation, e.g. `NCS_JAVA_VM_OPTIONS = -Xms1G -Xmx2G`
Please note that 1/2Gb are just examples, you most probably need to tweak those for your use case. Please also make sure the requests and limits in the
k8s deployment can handle the JVM memory requirements.

## Stateful Sets
https://kubernetes.io/docs/tutorials/stateful-application/basic-stateful-set/

## Persistent Volumes and Persistent Volume Claims
Persistent volumes (and claims) seems to be a great fit for providing volumes to the NSO containers. 

https://kubernetes.io/docs/concepts/storage/persistent-volumes/

## Readiness and Liveness Probes
K8s can utilize a readiness probe to determine if a container is ready to serve. The liveness probe is used to periodically check if the container is alive.

In the NSO LSA example project, simple TCP port probes are used. Another alternative would be to go to the HTTP API to verify that NSO is ready/alive.

## Pod Disruption Budgets
-TODO-

## Node taints and anti affinity
-TODO-
