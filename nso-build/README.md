# Build image for NSO
This image can be used to build packages before handing them over to a minimal image for running NSO.

## Example
Uses the nso-build to rebuild all packages and then copies the built and stripped packages to a image based on the
nso-system-base image.

```
from containers.cisco.com/frjansso/nso-build:5.1.1.1

COPY packages /tmp/packages/
SHELL ["bash", "-c"]
RUN source /opt/ncs/current/ncsrc && \
    for x in /tmp/packages/*; do make clean -C $x/src; make -C $x/src; done

    # Clean up the packages to minimize image
RUN rm -rf /tmp/packages/*/src; \
    rm -rf /tmp/packages/*/doc; \
    rm -rf /tmp/packages/*/netsim

from containers.cisco.com/frjansso/nso-system-base:5.1.1.1

COPY --from=0 /tmp/packages /var/opt/ncs/packages
COPY ncs-system-install.conf /etc/ncs/ncs.conf
```
