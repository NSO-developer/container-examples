from containers.cisco.com/frjansso/nso-base:4.5.2

RUN mkdir /root/nso-project

EXPOSE 12022 12023 12024 12025 12026 12027
EXPOSE 10022 10023 10024 10025 10026 10027

COPY run-netsim.sh /root/.
ENTRYPOINT ["/root/run-netsim.sh"]
