#!/bin/sh

# Delete old stale map folders first
rm -rf /CurrentWorld 

# Copy the running world as current world
cp -r /MyWorld /CurrentWorld 

# Generate the map
echo GENERATING MAP
/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 0 > /var/log/papyrus_overworld.log 
#/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 1 > /var/log/papyrus_nether.log 
#/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 2 > /var/log/papyrus_end.log 