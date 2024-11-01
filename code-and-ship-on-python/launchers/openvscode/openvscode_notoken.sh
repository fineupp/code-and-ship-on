FILE=/home/websson/.openvs.done


if test -f "$FILE"; then
    echo "$FILE exists."
    if [[ "$UPDATE_CONTINUE" ==  True ]]; then
	tar -xvzf /home/updates/continue.tar.gz -C /home/websson
    fi
    cd  /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin && ./openvscode-server  --host 0.0.0.0 --port 3000 --without-connection-token  &
else

cd /home/websson/ && wget https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v$VSVERSION/openvscode-server-v$VSVERSION-linux-x64.tar.gz 
cd /home/websson/ && tar -xzf openvscode-server-v$VSVERSION-linux-x64.tar.gz
cd /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin && chmod 777 ./openvscode-server && ./openvscode-server  --host 0.0.0.0 --port 3000 --without-connection-token  > /home/websson/openvscodeoutput.log &
rm /home/websson/openvscode-server-v$VSVERSION-linux-x64.tar.gz

sleep 10
/home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension Continue.continue
tar -xvzf /home/updates/continue.tar.gz -C /home/websson

sleep 5
/home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension ms-python.python

if [[ "$FIX_VS" ==  True ]]; then
/home/websson/launchers/openvscode/fix_vs.sh
fi

#cp /home/updates/config.json /home/websson/.continue

 	if [[ "$DJANGO" ==  True ]]
        then
        /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension batisteo.vscode-django
        /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension samuelcolvin.jinjahtml
        fi
 	
	if [[ "$FLASK" ==  True ]]
        then
        /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension cstrap.flask-snippets
        fi


touch /home/websson/.openvs.done

fi
