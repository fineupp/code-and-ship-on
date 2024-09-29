#!/usr/bin/env xonsh

import os.path
import time

path = '/home/websson/.django.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
		source-bash /home/websson/default_py_env/bin/activate &&  pip install Django

		cd /home/websson/ && mkdir Django_Projects
		
		cd /home/websson/Django_Projects && mkdir .pixi
		
		cd /home/websson/Django_Projects/.pixi && mkdir envs

		cd /home/websson/Django_Projects && source-bash /home/websson/default_py_env/bin/activate && django-admin startproject django_project .

		cd /home/websson/Django_Projects && source-bash /home/websson/default_py_env/bin/activate && python manage.py migrate

		cd /home/websson/Django_Projects && source-bash /home/websson/default_py_env/bin/activate && python manage.py createsuperuser --noinput

		/home/websson/mamba/bin/xonsh /home/websson/launchers/django/django_modifications.xsh


		time.sleep(int($INSTSLEEPTIME))

		cd /home/websson/Django_Projects && source-bash /home/websson/default_py_env/bin/activate && python manage.py runserver 0.0.0.0:80 &

                touch /home/websson/.django.done
else:
		time.sleep(int($RUNSLEEPTIME))
		cd /home/websson/Django_Projects && source-bash /home/websson/default_py_env/bin/activate && python manage.py runserver 0.0.0.0:80 &
