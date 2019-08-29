FROM bitnami/minideb

ARG NSOVER

COPY nso-$NSOVER.linux.x86_64.installer.bin /tmp/nso

RUN install_packages ant gawk openssh-client make xsltproc libxml2-utils default-jdk-headless python; \
    sh /tmp/nso --system-install; \
    # Generate SSH key in PEM format
    rm -f /etc/ncs/ssh/*; \
    ssh-keygen -m PEM -t rsa -f /etc/ncs/ssh/ssh_host_rsa_key -N ''; \
