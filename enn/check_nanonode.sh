#!/bin/bash
curl --connect-timeout 3 --max-time 5 -g -s -d '{ "action": "version" }' [::1]:7076 > /dev/null;
if [ $? -ne 0 ]; then
    echo "$(date) - Restarting Nano Node..."
    docker restart nanonode
fi;
