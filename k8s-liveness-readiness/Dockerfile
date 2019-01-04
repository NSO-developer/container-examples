FROM containers.cisco.com/frjansso/nso-system-base

RUN apt-get update; \
    apt-get install -y curl; \
    apt-get -y clean autoclean; \
    apt-get -y autoremove; \
    rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}/

COPY is-alive.sh /
COPY is-ready.sh /
COPY lr-test /var/opt/ncs/packages/lr-test/
