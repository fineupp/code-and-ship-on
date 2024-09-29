import os
import json
import os.path
from os import path
import subprocess

if 'DEDTERMINAL' in os.environ:
   terminal_json = os.getenv('DEDTERMINAL')
   terminal_dict= json.loads(terminal_json)
   print (terminal_dict['port'])
   print ('launching terminal')
   subprocess.call(['bash','/docker-scripts/launch_term.sh',str(terminal_dict['port']),str(terminal_dict['username']),str(terminal_dict['password'])])

