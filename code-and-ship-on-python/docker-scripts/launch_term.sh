cd /home/websson/
echo "terminal is starting"
/home/websson/launchers/term/ttyd.x86_64 -W -p $1 -c $2:$3 -m 2 /bin/bash &
