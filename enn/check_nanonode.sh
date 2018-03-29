#!/bin/bash
response=$(curl --connect-timeout 3 --max-time 5 -g -d '{ "action": "version" }' [::ffff:127.0.0.1]:7076);
if [ $? -ne 0 ]; then
    docker restart enn_nanonode_1
fi;