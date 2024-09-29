#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.emmett.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
		
		source-bash /home/websson/default_py_env/bin/activate &&  pip install emmett

		cd /home/websson/ && mkdir emmett_apps

		cp /home/websson/launchers/emmett/main.py /home/websson/emmett_apps/app.py

		cd /home/websson/emmett_apps && source-bash /home/websson/default_py_env/bin/activate && emmett serve --host 0.0.0.0 --port 80 &

                touch /home/websson/.emmett.done
else:
		cd /home/websson/emmett_apps && source-bash /home/websson/default_py_env/bin/activate && emmett serve --host 0.0.0.0 --port 80 &


