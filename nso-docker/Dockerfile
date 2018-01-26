# NSO base image
FROM ubuntu:latest

ARG NSOVER

# Install deps
COPY nso-$NSOVER.linux.x86_64.installer.bin /tmp/nso

RUN apt-get update;\ 
    apt-get install -y openssh-client default-jre-headless; \
    /tmp/nso /root/nso; \
    echo '. ~/nso/ncsrc' >> /root/.bashrc; \
    apt-get -y clean autoclean;\
    apt-get -y autoremove;\
    rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}/ 

EXPOSE 8080 830 2022 2023 4569

COPY run-nso.sh /root/.
ENTRYPOINT ["/root/run-nso.sh"]
