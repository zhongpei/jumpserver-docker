##方法1##

	docker-compose run jumpserver python manage.py syncdb
	
	手动数据库修改，把  admin用户添加role = "SU"

##方法2##
	docker-compose run jumpserver python /opt/jumpserver/install/next.py

