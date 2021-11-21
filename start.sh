#!/bin/bash
#script for starting version1.0

if [ ! -f server.jar ]
   then
     wget "https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar" -O /srv/server.jar
fi

if [ ! -f eula.txt ]
   then
     echo "eula=true" > /srv/eula.txt
fi

cd /srv && java -Xms1024M -Xms1024M -jar server.jar nogui