#!/bin/sh

echo CURRENT PID $$

echo RUNNING CRON SERVICE 

# Fix link-count, as cron is being a pain, and docker is making hardlink count >0 (very high)
# 	https://unix.stackexchange.com/questions/453006/getting-cron-to-work-on-docker
touch /etc/crontab /etc/cron.*/*

service cron start

echo RUNNING MAP GENERATOR FOR THE FIRST TIME

generate_map.sh

echo RUNNING HTTPD SERVICE

httpd-foreground