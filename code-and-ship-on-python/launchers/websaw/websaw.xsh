#!/usr/bin/env xonsh

import os.path

path = '/home/websson/.websaw.done'

check_file = os.path.isfile(path)

if check_file == False:

        print ("Checking for other envs")

        if 'FINEUPPDEV' in ${...}:
                print ("FINEUPPDEV is here")
        else:

		cd /home/websson/ && git clone -b develop https://github.com/Eudorajab1/websaw.git && source-bash /home/websson/default_py_env/bin/activate && cd /home/websson/websaw &&  pip install -e .[full] &&  pip install rocket3 &&   pip install Pillow &&  pip install setuptools

		cd /home/websson && git clone https://github.com/Eudorajab1/pyjsaw.git &&  cd /home/websson/pyjsaw && source-bash /home/websson/default_py_env/bin/activate &&  pip install -e .

		cd /home/websson/websaw && rm -rf .git
		cd /home/websson/pyjsaw && rm -rf .git

		cd /home/websson/websaw &&  source-bash /home/websson/default_py_env/bin/activate && python websaw run /home/websson/websaw/apps -s default --watch=sync -H 0.0.0.0 -P 80 &

                touch /home/websson/.websaw.done
else:
		cd /home/websson/websaw/
                source-bash  /home/websson/default_py_env/bin/activate && python websaw run apps -s default --watch=sync -H 0.0.0.0 -P 80 &
