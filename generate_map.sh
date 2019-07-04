#!/bin/sh

echo $(date)

echo CLEANING UP CURRENT WORLD
# Delete old stale map folders first
rm -rf /CurrentWorld 

echo EXPORTING RUNNING WORLD
# Copy the running world as current world
cp -r /MyWorld /CurrentWorld 

# Generate the map save to a log file and pipe to stdout
echo GENERATING MAP
/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 0
# removed /var/log/papyrus_overworld.log temporarily and piping to stdout >&1
#/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 1 > /var/log/papyrus_nether.log >&1
#/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 2 > /var/log/papyrus_end.log >&1
