#!/bin/bash

FILE=/home/websson/.git.done
if test -f "$FILE"; then
    echo "GIT exists."
else

if [ -z "$GITURL" ]; then
  
	echo "The GITURL is not set."
else
	if [ -z "$GITTOKEN" ]; then
  		
		echo "The GITOKEN is not set."
	
	else
		export GITURL="$(printf '%s\n' "${GITURL//"https://"/}")"
		export GITURL="$(echo https://$GITTOKEN@$GITURL)"
	
	fi

	echo "Cloning " $GITPREPARAMS $GITURL $GITPOSTPARAMS
 	cd /home/websson/ && git clone $GITPREPARAMS $GITURL $GITPOSTPARAMS
	touch /home/websson/.git.done
fi
fi


FILE=/home/websson/.servicefile.done
if test -f "$FILE"; then
    echo "SERVICE exists."
else

	if [ -z "$ENCODEDSERVICEFILE" ]; then
  		echo "The SERVICEFILE is not set."
	else
  		echo "$ENCODEDSERVICEFILE" | base64 --decode > /home/websson/startup/startme_from_env.sh
  		chmod +x /home/websson/startup/startme_from_env.sh
   		if [[ -z "$SECRETS" ]]; then
        		echo "no secrets to make available"
			/home/websson/startup/startme_from_env.sh
     		else
  			/home/websson/mamba/bin/python /docker-scripts/service_secrets.py
			. /home/websson/env && /home/websson/startup/startme_from_env.sh
			touch /home/websson/.servicefile.done
     		fi
	fi
fi


FILE=/home/websson/.secretsdown.done
if test -f "$FILE"; then
    echo "SECRETSDOWN exists."

else

if [ -z "$SECRETSURL" ]; then
  
	echo "The SECRETSURL is not set."
else
	if [ -z "$SECRETSHEADER" ]; then
  		
		echo "The SECRETS HEADER is not set. Downloading without headers"
		cd /home/websson/startup && wget   $SECRETSURL
		touch /home/websson/.secretsdown.done
	
	else
		echo "The SECRETS HEADER is set. Downloading with headers"
		cd /home/websson/startup/ && wget  --header="$SECRETSHEADER" $SECRETSURL
		touch /home/websson/.secretsdown.done
               	
	fi
fi
export set SERVICESECRETS=$(cat /home/websson/startup/secrets)
rm /home/websson/startup/secrets
/home/websson/mamba/bin/python /docker-scripts/service_secrets.py
fi


FILE=/home/websson/.servicedown.done
if test -f "$FILE"; then
    echo "SERVICEDOWN exists."

else
	
if [ -z "$SERVICEURL" ]; then
  
	echo "The SERVICEURL is not set."
else
	if [ -z "$SERVICEHEADER" ]; then
  		
		echo "The SERVICE HEADER is not set. Downloading without headers"
		cd /home/websson/startup && wget   $SERVICEURL
  		chmod +x /home/websson/startup/startme_from_env.sh
   		
		if [[ -z "$SERVICESECRETS" ]]; then
        		echo "no secrets to make available"
			/home/websson/startup/startme_from_env.sh
     		else
  			/home/websson/mamba/bin/python /docker-scripts/service_secrets.py
			. /home/websson/env && /home/websson/startup/startme_from_env.sh
		fi
		
		touch /home/websson/.servicedown.done
	
	else
		echo "The SERVICE HEADER is set. Downloading with headers"
		cd /home/websson/startup/ && wget  --header="$SERVICEHEADER" $SERVICEURL
		touch /home/websson/.servicedown.done
               	
	fi

fi
fi
