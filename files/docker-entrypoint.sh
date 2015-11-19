#!/bin/bash

/etc/init.d/ssh start
/etc/init.d/slapd start
#hashed_ldap_passwd=$(/usr/sbin/slappasswd -s $LDAP_ADMIN_PASS)
#ldapmodify -Y EXTERNAL -H ldapi:/// < rootpw.ldif

cd /opt/jumpserver

python manage.py runserver 0.0.0.0:80 &
python log_handler.py

