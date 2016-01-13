#!/bin/bash

service ssh start

cd /opt/jumpserver && python manage.py runserver 0.0.0.0:80
