#!/bin/sh

echo RUNNING HTTPD SERVICE

httpd-foreground

echo RUNNING CRON SERVICE 

# fix link-count, as cron is being a pain, and docker is making hardlink count >0 (very high)
# From https://unix.stackexchange.com/questions/453006/getting-cron-to-work-on-docker
#touch /etc/crontab /etc/cron.*/*

service cron start

generate_map.sh