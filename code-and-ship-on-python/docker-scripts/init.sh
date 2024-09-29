#!/bin/bash

export CUSTOM=False


if [[ -z "$DEDTERMINAL" ]]; then
	echo "TERMINAL EMPTY"
else
	/home/websson/mamba/bin/python  /docker-scripts/term.py
fi

# ADDITIONAL PACKAGES TO INSTALL DURING BOOT ?
#sudo  /home/websson/startup/install_packages.sh

/etc/init.d/nginx stop


 
if [[ ! -v JUPYTERLAB ]]  &&  [[ ! -v CONNECT_TOKEN ]] &&  [[ "$SUPERVISOR" ==  True ]] ; then
	FILE=/home/websson/startup/.supervisor.deactivated
	if test -f "$FILE"; then
		echo "SUPERVISOR OFF BECAUSE OF FILE"
	else
	echo "SUPERVISOR ON"
	/home/websson/mamba/bin/supervisord -c /home/websson/startup/supervisord.conf
	fi
else
#if [[ ! -v SUPERVISOR ]] || [[ "$SUPERVISOR"==False ]]; then
	echo "SUPERVISOR OFF BECAUSE OF ENV VAR"
fi



# OVERWRITING FRAMEWORK START SEQUENCE WITH CUSTOM SCRIPT IF SET
FILE=/home/websson/startup/startme.sh
if test -f "$FILE"; then
    echo "$FILE exists."
     export CUSTOM=True
    . /home/websson/startup/startme.sh &

fi




if [[ "$WEBSAW" ==  True ]] && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$WEBSAW is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/websaw/websaw.xsh &
fi


if [[ "$EMMETT" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$EMMETT is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/emmett/emmett.xsh &
fi

if [[ "$JAMPY" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$JAMPY is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/jampy/jampy.xsh &
fi


if [[ "$DJANGO" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$DJANGO is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/django/django.xsh &
fi

if [[ "$FASTAPI" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$FASTAPI is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/fastapi/fastapi.xsh &
fi

if [[ "$PY4WEB" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$PY4WEB is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/py4web/py4web.xsh &
fi

if [[ "$WEB2PY" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$WEB2PY is True"
	
      /home/websson/mamba/bin/xonsh /home/websson/launchers/web2py/web2py.xsh &
fi

if [[ "$STREAMLIT" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$STREAMLIT is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/streamlit/streamlit.xsh &
fi

if [[ "$FLASK" ==  True ]]  && [[ "$CUSTOM" ==  False ]] ;

then
      echo "\$FLASK is True"
      	
	/home/websson/mamba/bin/xonsh /home/websson/launchers/flask/flask.xsh &
fi


if [[ ! -v VSTOKEN ]]; then
    echo "VSTOKEN is not set"
    
    VSFILE=/home/websson/.openvs.done
    if test -f "$VSFILE"; then

    rm -rf /home/websson/openvscode-server-v$VSVERSION-linux-x64/
    rm /home/websson/openvscodeoutput.log
    rm /home/websson/.openvs.done
    fi

elif [[ -z "$VSTOKEN" ]]; then
    echo "VSTOKEN is set to the empty string"
    
    VSFILE=/home/websson/.openvs.done
    if test -f "$VSFILE"; then

    rm -rf /home/websson/openvscode-server-v$VSVERSION-linux-x64/
    rm /home/websson/openvscodeoutput.log
    rm /home/websson/.openvs.done
    fi

elif [[ "$VSTOKEN" ==  vstoken ]]; then
    echo "VSTOKEN is set to default"
    
    VSFILE=/home/websson/.openvs.done
    if test -f "$VSFILE"; then

    rm -rf /home/websson/openvscode-server-v$VSVERSION-linux-x64/
    rm /home/websson/openvscodeoutput.log
    rm /home/websson/.openvs.done
    fi
else
      cd /home/websson &&  . /home/websson/launchers/openvscode/openvscode.sh &
fi

if [[ ! -v CONNECTION_TOKEN ]]; then
    echo "CONNECTION_TOKEN is not set"

elif [[ -z "$CONNECTION_TOKEN" ]]; then
    echo "CONNECTION_TOKEN is set to the empty string"

else
      cd /home/websson/launchers && rm -rf flask  
      cd /home/websson/launchers && rm -rf django 
      cd /home/websson/launchers && rm -rf emmett  
      cd /home/websson/launchers && rm -rf fastapi 
      cd /home/websson/launchers && rm -rf term
      cd /home/websson/launchers && rm -rf jampy
      cd /home/websson/launchers && rm -rf jupyterlab
      cd /home/websson/launchers && rm -rf nginx
      cd /home/websson/launchers && rm -rf py4web
      cd /home/websson/launchers && rm -rf streamlit
      cd /home/websson/launchers && rm -rf web2py
      cd /home/websson/launchers && rm -rf websaw
      killall supervisord
      cd /home/websson/ && rm -rf startup
      cd /home/websson/ && rm -rf log
      cd /home/websson/ && rm -rf nginx
      cd /home/websson/ && rm  supervisor.sock
      cd /home/websson &&  . /home/websson/launchers/openvscode/openvscode_conn_token.sh &
fi


if [[ ! -v JUPTOKEN ]]; then
    echo "JUPTOKEN is not set"
elif [[ -z "$JUPTOKEN" ]]; then
    echo "JUPTOKEN is set to the empty string"
elif [[ "$JUPTOKEN" ==  juptoken ]]; then
    echo "JUPTOKEN is set to default"
else
	. /home/websson/launchers/jupyterlab/jupyterlab.sh &
fi


if [[ "$JUPYTERLAB" ==  True ]]

then
	rm -rf default_py_env
	. /home/websson/launchers/jupyterlab/jupyterlab_alone.sh &
fi

if [[ "$PYTHONONLY" ==  True ]]

then
#	. /home/websson/launchers/term/term_standalone.sh
        echo "Python only.. doing nothing"

fi

KEYFILE=/home/websson/.ssh.done
if test -f "$KEYFILE"; then

	echo "SSH DONE"

else
	if [[ ! -v JUPYTERLAB ]] && [[  ! -v CONNECT_TOKEN  ]] && [[ "$SSHKEY" ==  True ]]; then
		echo "GENERATING KEY"
		cd /home/websson/.keys && ./create-keypair.sh
		cd /home/websson
		rm -rf /home/websson/.keys
		touch /home/websson/.ssh.done
	else
		echo "NOT GENERATING KEY"
		touch /home/websson/.ssh.done
	fi
fi


/usr/sbin/websson_trigger_reset &
sudo /usr/sbin/sshd -D 
exec $@
