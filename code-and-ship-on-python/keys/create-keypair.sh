#!/bin/bash

if [[ "$SSHKEY" ==  False ]]; then
                echo "KEY IS FALSE"
else

cd /home/websson/.keys
ssh-keygen -q -N "" -t rsa -b 4096 -C $ENVNAME -f /home/websson/.keys/id_rsa

base64 id_rsa > id_rsa.b64
base64 id_rsa.pub > id_rsa.pub.b64

echo "{\""data\"": {\""envname\"": \""$ENVNAME\"",\""username\"": \""$(whoami)\"",\""key\"":\""  > payload.json

cat id_rsa.b64 >> payload.json

echo "\"",\""pubkey\"":\"""  >> payload.json

cat id_rsa.pub.b64 >> payload.json

echo "\""}} >> payload.json

if [[ ! -v KEYTOKEN ]]; then
    echo "KEYTOKEN is not set"
    cp id_rsa /home/websson
    echo "SSH PRIVATEKEY" | cat - id_rsa 
    echo "SSH PRIVATEKEY" | cat - id_rsa | logger 
else
curl --location --request POST "$KEYURL$ENVNAME" \
--header "X-Vault-Token: $KEYTOKEN" \
--header "Content-Type: application/json" \
--data @payload.json
fi

mkdir ~/.ssh
touch ~/.ssh/authorized_keys
cat id_rsa.pub >>  ~/.ssh/authorized_keys


rm id_rsa
rm id_rsa.b64
rm id_rsa.pub
rm id_rsa.pub.b64
rm payload.json
fi
