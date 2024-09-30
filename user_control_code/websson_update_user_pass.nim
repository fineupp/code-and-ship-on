import nimcrypt
import std/os

var password:string
var passline: string


var text = """root:*:19856:0:99999:7:::
daemon:*:19856:0:99999:7:::
bin:*:19856:0:99999:7:::
sys:*:19856:0:99999:7:::
sync:*:19856:0:99999:7:::
games:*:19856:0:99999:7:::
man:*:19856:0:99999:7:::
lp:*:19856:0:99999:7:::
mail:*:19856:0:99999:7:::
news:*:19856:0:99999:7:::
uucp:*:19856:0:99999:7:::
proxy:*:19856:0:99999:7:::
www-data:*:19856:0:99999:7:::
backup:*:19856:0:99999:7:::
list:*:19856:0:99999:7:::
irc:*:19856:0:99999:7:::
_apt:*:19856:0:99999:7:::
nobody:*:19856:0:99999:7:::
systemd-network:!*:19914::::::
messagebus:!:19914::::::
sshd:!:19914::::::
polkitd:!*:19914::::::
"""

passline.add("""websson:""")
   
password=paramStr(1)

var salt = "$6$webssonsalt"

passline.add(crypt(password,salt))

passline.add(""":19914:0:99999:7:::""")

text.add(passline)

writeFile("/etc/shadow", text)

var outp = open("/etc/bash.bashrc",fmAppend)

outp.writeLine("unset USERPASS") 

outp.close()

echo "DONE"
