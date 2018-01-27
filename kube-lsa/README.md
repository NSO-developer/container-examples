# NSO/LSA Using Kubernetes

This small projects tries to demo how you can run NSO in Docker containers using
Kubernetes.

It consists of four containers, one upper NSO (CSO), two lower NSOs and a
container containing the NETSIM devices.

## nso-base Image
The containers are all based on an image called nso-base, which is internally
available on Cisco. If you're outside Cisco, please ping me and I'll try to
publish the Dockerfile and script.

## Running
To successfully build, you'll need to source NSO 4.5 ncsrc.
```
# make all start
...
BUILD SUCCESSFUL
...
deployment "nso-lsa-upper" created
deployment "nso-lsa-lower-1" created
service "nso-lsa-lower-1" created
deployment "nso-lsa-lower-2" created
service "nso-lsa-lower-2" created
deployment "nso-lsa-netsim" created
service "nso-lsa-netsim" created

# kubectl get po
NAME                               READY     STATUS    RESTARTS   AGE
nso-lsa-lower-1-689f87d585-h5tjl   1/1       Running   0          6s
nso-lsa-lower-2-65475d9fb9-hzlsk   1/1       Running   0          6s
nso-lsa-netsim-5749b76755-drxbq    1/1       Running   0          5s
nso-lsa-upper-6b5f74c46d-dwffv     1/1       Running   0          6s
```

## Intialize
To get all address in place and sync devices, please run the init script.
```
./init.sh
...
```
Make sure you don't get any errors here.

## Test
```
./cli.sh
root@nso-lsa-upper-6b5f74c46d-qzjbq:/# ncs_cli -u admin
[57/8715]

admin connected from 127.0.0.1 using console on nso-lsa-upper-6b5f74c46d-qzjbq
admin@upper-nso> configure
Entering configuration mode private
[ok][2017-12-19 20:48:11]

[edit]
admin@upper-nso% set cfs-vlan test a-router ex0 z-router ex4 iface eth0 unit 1 vid 2
[ok][2017-12-19 20:48:29]

[edit]
admin@upper-nso% commit dry-run
cli {
    local-node {
        data  devices {
                  device lower-nso-1 {
                      config {
             +            rfs-vlan:vlan test {
             +                router ex0;
             +                iface eth0;
             +                unit 1;
             +                vid 2;
             +                description "Interface owned by CFS: test";
             +            }
                      }
                  }
                  device lower-nso-2 {
                      config {
             +            rfs-vlan:vlan test {
             +                router ex4;
             +                iface eth0;
             +                unit 1;
             +                vid 2;
             +                description "Interface owned by CFS: test";
             +            }
                      }
                  }
              }
             +cfs-vlan test {
             +    a-router ex0;
             +    z-router ex4;
             +    iface eth0;
             +    unit 1;
             +    vid 2;
             +}
    }
    lsa-node {
        name lower-nso-2
        data  devices {
                  device ex4 {
                      config {
                          r:sys {
                              interfaces {
                                  interface eth0 {
             +                        enabled;
                                      unit 1 {
             +                            description "Interface owned by CFS:
                                          test";
             +                            vlan-id 2;
                                      }
                                  }
                              }
                          }
                      }
                  }
              }
             +vlan test {
             +    router ex4;
             +    iface eth0;
             +    unit 1;
             +    vid 2;
             +    description "Interface owned by CFS: test";
             +}
    }
}
[edit]
admin@upper-nso% commit
Commit complete.
```
