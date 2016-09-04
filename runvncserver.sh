#!/usr/bin/env bash

echo "+------------------------------------"
echo "| Server address: " $(ifconfig enp0s3 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}')
echo "| Starting vnc4server ..."
vnc4server -geometry 1440x900 :1 >/dev/null 2>&1
CNT=$(ps -ef | grep -ic vnc)
if [ $CNT -le 1 ]; then
    echo "| ** ERROR: Failed to start vnc4server"
else
    echo "| vnc4server started successful!"
fi
echo "+------------------------------------"
