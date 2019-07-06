#!/bin/bash

echo CURRENT PID $$
echo CHECKING ENV VARIABLES IF SET
echo $LEVEL_NETHER, $LEVEL_END, $CONFIG_THREADS, $CONFIG_OUTFILE , $CONFIG_QUALITY

# The environment variables are not loaded into cron. 
# 	https://stackoverflow.com/questions/27771781/how-can-i-access-docker-set-environment-variables-from-a-cron-job
echo WRITING ENV VARIABLES TO FILE
declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID' > /container.env

echo RUNNING CRON SERVICE 

# Fix link-count, as cron is being a pain, and docker is making hardlink count >0 (very high)
# 	https://unix.stackexchange.com/questions/453006/getting-cron-to-work-on-docker
touch /etc/crontab /etc/cron.*/*

service cron start

echo RUNNING MAP GENERATOR FOR THE FIRST TIME

generate_map.sh

echo RUNNING HTTPD SERVICE

httpd-foreground