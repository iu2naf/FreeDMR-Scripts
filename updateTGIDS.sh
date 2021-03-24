#!/bin/bash

sleep $[ ( $RANDOM % 1800 )  + 1 ]s

cd /opt/HBMonv2
FILE_NAME="talkgroup_ids.json"
FETCH_URL="http://downloads.freedmr.uk/downloads/talkgroup_ids.json"

OLD_MD5=`md5sum ${FILE_NAME}`
wget -O ${FILE_NAME} ${FETCH_URL}
NEW_MD5=`md5sum ${FILE_NAME}`

if [ "$NEW_MD5" != "$OLD_MD5" ]
then
  echo "File is new, restarting"
  systemctl restart hbmon
fi

