FROM ubuntu:18.04

ARG NSOVER

COPY nso-$NSOVER.linux.x86_64.installer.bin /tmp/nso
RUN apt-get update; \
    apt-get install -y openssh-client; \
    /tmp/nso --system-install

FROM ubuntu:18.04

RUN apt-get update; \
    apt-get install -y openssh-client default-jre-headless python curl; \
    echo '. /opt/ncs/current/ncsrc' >> /root/.bashrc; \
    apt-get -y clean autoclean; \
    apt-get -y autoremove; \
    rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}/; \
    mkdir /var/log/ncs

COPY --from=0 /etc/ncs /etc/ncs/
COPY --from=0 /var/opt/ncs /var/opt/ncs/
COPY --from=0 /opt/ncs /opt/ncs/
COPY --from=0 /etc/init.d/ncs /etc/init.d/.

COPY run-nso.sh /

EXPOSE 8080 830 2022 2023 4569

CMD ["/run-nso.sh"]
