#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.fastapi.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
		source-bash /home/websson/default_py_env/bin/activate &&  pip install fastapi[all]

		cd /home/websson/ && mkdir fastapi_apps

		cp /home/websson/launchers/fastapi/main.py /home/websson/fastapi_apps

		cd /home/websson/fastapi_apps && source-bash /home/websson/default_py_env/bin/activate && uvicorn main:app --reload --host 0.0.0.0 --port 80 &

                touch /home/websson/.fastapi.done
else:
		cd /home/websson/fastapi_apps && source-bash /home/websson/default_py_env/bin/activate && uvicorn main:app --reload --host 0.0.0.0 --port 80 &


