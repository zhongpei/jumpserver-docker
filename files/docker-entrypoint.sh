#!/bin/bash

/etc/init.d/ssh start
/etc/init.d/slapd start
#hashed_ldap_passwd=$(/usr/sbin/slappasswd -s $LDAP_ADMIN_PASS)
#ldapmodify -Y EXTERNAL -H ldapi:/// < rootpw.ldif

MAIL_USER=${MAIL_SMTP_USER%:*}
MAIL_PASS=${MAIL_SMTP_USER#*:}

sed -i \
    -e 's/^host = 127.0.0.1/host = mysql/g' \
    -e 's/^user = jumpserver/user = '$MYSQL_USER'/g' \
    -e 's/^password = mysql234/password = '$MYSQL_PASSWORD'/g' \
    -e 's/^email_host = .*/email_host = mail/g' \
    -e 's/^email_host_user = .*/email_host_user = '$MAIL_USER'/g' \
    -e 's/^email_host_password = .*/email_host_password = '$MAIL_PASS'/g' \
    /opt/jumpserver/jumpserver.conf

cd /opt/jumpserver

echo no | python manage.py syncdb

python manage.py runserver 0.0.0.0:80 &
python log_handler.py

