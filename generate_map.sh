#!/bin/sh

echo GENERATING MAP
RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 0
#RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 1
#RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 2