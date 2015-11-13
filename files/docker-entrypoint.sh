#!/bin/bash

/etc/init.d/ssh start
/etc/init.d/slapd start

cd /opt/jumpserver

python manage.py runserver 0.0.0.0:80 &
python log_handler.py

