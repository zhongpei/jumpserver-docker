FROM ubuntu:14.04
RUN mkdir /opt/jumpserver
COPY . /opt/jumpserver
RUN chmod +x /opt/jumpserver/install_server_ubuntu.sh && /opt/jumpserver/install_server_ubuntu.sh
EXPOSE 80 22
ENTRYPOINT ["/opt/jumpserver/docker-entrypoint.sh"]

