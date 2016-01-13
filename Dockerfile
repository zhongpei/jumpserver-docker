FROM python:2.7

RUN  git clone https://github.com/ibuler/jumpserver.git /opt/jumpserver
WORKDIR /opt/jumpserver
RUN  cd /opt/jumpserver/install && pip install -r requirements.txt
RUN apt-get update && apt-get install -y sshpass lrzsz openssh-server
COPY ./service.sh /service.sh
RUN chmod +x /service.sh
CMD ["/service.sh"]
EXPOSE 80 22 
