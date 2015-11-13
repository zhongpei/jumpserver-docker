#!/usr/bin/env bash

DEPENDS="nodejs python-django ssh python-paramiko python-ldap python-ecdsa python-django-shortuuidfield python-psutil slapd ldapscripts python-pycryptopp python-pip"
APP_DIR="/opt/jumpserver"

cd $APP_DIR
echo 'slapd	slapd/domain	string	jumpserver.org' | debconf-set-selections
echo 'slapd	shared/organization	string	jumpserver' | debconf-set-selections
apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install $DEPENDS
mkdir -p logs/{connect,exec_cmds} && chmod -R 777 logs
chmod +x *.py *.sh
cp docs/zzjumpserver.sh /etc/profile.d/
pip install django-uuidfield
echo no | python manage.py syncdb

rm -f /var/lib/ldap/{__db.*,alock,dn2id.bdb,id2entry.bdb,log.0000000001,objectClass.bdb}
/etc/init.d/slapd start
cat > /tmp/resetpw.ldif <<EOF
dn: olcDatabase={1}hdb,cn=config
replace: olcRootPW
olcRootPW: {SSHA}ZEYLKCfKfZrGSFs6c6FfG9JhaNO9uUxP
EOF

ldapmodify -Y EXTERNAL -H ldapi:/// < /tmp/resetpw.ldif

ldapadd -x -w secret234 -D "cn=admin,dc=jumpserver,dc=org" -f base.ldif
ldapadd -x -w secret234 -D "cn=admin,dc=jumpserver,dc=org" -f group.ldif
#ldapadd -x -w secret234 -D "cn=admin,dc=jumpserver,dc=org" -f passwd.ldif
#ldapadd -x -w secret234 -D "cn=admin,dc=jumpserver,dc=org" -f sudo.ldif

#ldapdelete -x -D "cn=admin,dc=jumpserver,dc=org" -w secret234 "uid=testuser,ou=People,dc=jumpserver,dc=org"
#ldapdelete -x -D "cn=admin,dc=jumpserver,dc=org" -w secret234 "cn=testuser,ou=Sudoers,dc=jumpserver,dc=org"
