FROM ubuntu:14.04
RUN mkdir /opt/jumpserver
COPY jumpserver-hhding /opt/jumpserver
COPY files /tmp
RUN /tmp/install.sh

EXPOSE 80 22
ENTRYPOINT ["/docker-entrypoint.sh"]

