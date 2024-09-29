#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.jampy.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
		source-bash /home/websson/default_py_env/bin/activate && pip install jam.py

		cd /home/websson/ && mkdir jampy

		cd /home/websson/jampy/ && source-bash /home/websson/default_py_env/bin/activate && jam-project.py

		cd /home/websson/jampy/ && source-bash /home/websson/default_py_env/bin/activate && ./server.py 80 &

                touch /home/websson/.jampy.done
else:
		cd /home/websson/jampy/ && source-bash /home/websson/default_py_env/bin/activate && ./server.py 80 &
