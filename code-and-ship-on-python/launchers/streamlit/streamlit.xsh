#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.streamlit.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'TEST' in ${...}:
                print ("Test exists")
        else:
                source-bash /home/websson/default_py_env/bin/activate &&  pip install streamlit && pip install pandas matplotlib scikit-learn

                cd /home/websson/ && mkdir streamlit_apps

                cp /home/websson/launchers/streamlit/main.py /home/websson/streamlit_apps

                cd /home/websson/streamlit_apps && source-bash /home/websson/default_py_env/bin/activate && streamlit run main.py --server.port 80 --server.address 0.0.0.0 --server.runOnSave true &

                touch /home/websson/.streamlit.done
else:

                cd /home/websson/streamlit_apps && source-bash /home/websson/default_py_env/bin/activate && streamlit run main.py --server.port 80 --server.address 0.0.0.0 --server.runOnSave true &


