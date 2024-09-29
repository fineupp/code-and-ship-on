#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.web2py.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'FINEUPPDEV' in ${...}:
                print ("FINEUPPDEV is here")
        else:
                cd /home/websson/ && git clone --recursive https://github.com/web2py/web2py.git && source-bash /home/websson/default_py_env/bin/activate &&  pip install rocket3 &&  pip install Pillow

                cd /home/websson/web2py &&  source-bash /home/websson/default_py_env/bin/activate && python web2py.py -a $WEB2PY_PASS -i 0.0.0.0 -p 80 &


                touch /home/websson/.web2py.done
else:
		cd /home/websson/web2py &&  source-bash /home/websson/default_py_env/bin/activate && python web2py.py -a $WEB2PY_PASS -i 0.0.0.0 -p 80 &
