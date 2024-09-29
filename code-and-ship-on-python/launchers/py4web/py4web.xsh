#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.py4web.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
                
        else:
                cd /home/websson/ && git clone https://github.com/web2py/py4web.git && source-bash /home/websson/default_py_env/bin/activate && cd /home/websson/py4web &&  pip install -e . &&  pip install rocket3 &&   pip install Pillow && pip install setuptools

                cd /home/websson/py4web && source-bash /home/websson/default_py_env/bin/activate && python py4web.py setup /home/websson/py4web/apps

                cd /home/websson/py4web && source-bash /home/websson/default_py_env/bin/activate && python py4web.py set_password --password $PY4WEB_PASS

                cd /home/websson/py4web && source-bash /home/websson/default_py_env/bin/activate && python py4web.py run /home/websson/py4web/apps -s default --watch=sync -H 0.0.0.0 -P 80 &

                touch /home/websson/.py4web.done

else:

                cd /home/websson/py4web && source-bash /home/websson/default_py_env/bin/activate && python py4web.py run /home/websson/py4web/apps -s default --watch=sync -H 0.0.0.0 -P 80 &
