#!/bin/sh

echo GENERATING MAP
/papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 0 > /var/log/papyrus_overworld.log 
#/papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 1
#/papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 2