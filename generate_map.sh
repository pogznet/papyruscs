#!/bin/sh

echo STARTING MAP GENERATION
echo $(date)

echo CURRENT PID $$

echo CLEANING UP CURRENT WORLD
# Delete old stale map folders first
rm -rf /CurrentWorld 

echo EXPORTING RUNNING WORLD
# Copy the running world as current world
cp -r /MyWorld /CurrentWorld 

# Generate the map save to a log file and pipe to stdout
echo GENERATING MAP
/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" --threads $CONFIG_THREADS -f $CONFIG_OUTFILE -q $CONFIG_QUALITY -d 0 > /var/log/papyrus_overworld.log

# Check if we should generate nether
one=1;

echo GENERATING NETHER
if [ $LEVEL_NETHER -eq $one ]
	then
		/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" --threads $CONFIG_THREADS -f $CONFIG_OUTFILE -q $CONFIG_QUALITY -d 1 > /var/log/papyrus_nether.log
else
	echo NOT GENERATING NETHER MAP 
fi

# Check if we should generate end
echo GENERATING END
if [ $LEVEL_END -eq $one ]
	then
		/papyruscs/PapyrusCs --world="/CurrentWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" --threads $CONFIG_THREADS -f $CONFIG_OUTFILE -q $CONFIG_QUALITY -d 2 > /var/log/papyrus_end.log
else
	echo NOT GENERATING END MAP 
fi

echo DONE WITH MAP GENERATION
echo $(date)