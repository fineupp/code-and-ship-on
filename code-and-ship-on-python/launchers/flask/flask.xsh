#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.flask.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
		
		source-bash /home/websson/default_py_env/bin/activate &&  pip install flask

		cd /home/websson/ && mkdir flask_apps

		cp /home/websson/launchers/flask/main.py /home/websson/flask_apps

		cd /home/websson/flask_apps && source-bash /home/websson/default_py_env/bin/activate && python main.py &
                
		touch /home/websson/.flask.done
else:
		cd /home/websson/flask_apps && source-bash /home/websson/default_py_env/bin/activate && python main.py &
