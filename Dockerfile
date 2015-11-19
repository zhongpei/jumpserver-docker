FROM ubuntu:14.04
RUN mkdir /opt/jumpserver
COPY jumpserver /opt/jumpserver
COPY files /tmp
RUN /tmp/install.sh
EXPOSE 80 22 389
ENTRYPOINT ["/docker-entrypoint.sh"]

