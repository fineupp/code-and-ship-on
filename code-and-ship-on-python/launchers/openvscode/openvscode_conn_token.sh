FILE=/home/websson/.openvs.done


if test -f "$FILE"; then
    echo "$FILE exists."
    cd  /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin && ./openvscode-server  --host 0.0.0.0 --port 3000 --connection-token $CONNECTION_TOKEN &
else

cd /home/websson/ && wget https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v$VSVERSION/openvscode-server-v$VSVERSION-linux-x64.tar.gz 
cd /home/websson/ && tar -xzf openvscode-server-v$VSVERSION-linux-x64.tar.gz
cd /home/websson/openvscode-server-v$VSVERSION-linux-x64/bin && chmod 777 ./openvscode-server && ./openvscode-server  --host 0.0.0.0 --port 3000 --connection-token $CONNECTION_TOKEN > /home/websson/openvscodeoutput.log &
rm /home/websson/openvscode-server-v$VSVERSION-linux-x64.tar.gz



/home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension Continue.continue
tar -xvzf /home/updates/continue.tar.gz -C /home/websson


/home/websson/openvscode-server-v$VSVERSION-linux-x64/bin/openvscode-server --install-extension ms-python.python

if [[ "$FIX_VS" ==  True ]]; then
/home/websson/launchers/openvscode/fix_vs.sh
fi


touch /home/websson/.openvs.done

fi
