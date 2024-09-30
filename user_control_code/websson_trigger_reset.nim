import os

sleep 15000 # Sleeps for 15000ms = 15s
#sleep 8000 # Sleeps for 8000ms = 8s


if not existsEnv("USERPASS"):
   discard execShellCmd("sudo /usr/sbin/websson_user_reset")
else:
   discard execShellCmd("sudo /usr/sbin/websson_update_user_pass $USERPASS")
   discard execShellCmd("unset USERPASS")
