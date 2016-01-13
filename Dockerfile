FROM python:2.7

RUN  git clone https://github.com/ibuler/jumpserver.git /opt/jumpserver
WORKDIR /opt/jumpserver
RUN  cd /opt/jumpserver/install && pip install -r requirements.txt
RUN apt-get update && apt-get install  sshpass lrzsz
EXPOSE 80 22 389
