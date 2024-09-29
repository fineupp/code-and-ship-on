export set FOLDER=$(find /home/websson/.openvscode-server/extensions -maxdepth 1 -type d -name '*ms-python.python*' -print -quit)
echo $FOLDER
cd $FOLDER && cp /home/websson/launchers/openvscode/fix_json.py .
cd $FOLDER && python fix_json.py > new.json
cd $FOLDER && mv new.json package.json
cd $FOLDER && rm /home/websson/launchers/openvscode/fix_json.py 
