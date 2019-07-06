# PapyrusCs Docker Image

## Pre-requisites
- You need to generate the HTML files and the respective files at least ONCE. This removes the burden on the Docker image to do the first generation. I suggest reducing the initial generation quality to jpg 50.
- You need to be able to mount your Minecraft map data so that this would be read by the generator.

## What you need to run

```
docker run -d -p 8080:80 \
    -v /local/minecraft/world/directory:/MyWorld \
    -v /local/directory/for/webfiles:/usr/local/apache2/htdocs/ \
    papyruscs
```

## Environment variables

`LEVEL_NETHER` (1 or 0) to render nether or not 
`LEVEL_END` (1 or 0) to render end level or not 
`CONFIG_THREADS`
`CONFIG_OUTFILE`
`CONFIG_QUALITY`

See default values and accepted parameters in https://github.com/mjungnickel18/papyruscs#usage

## Under the hood

### The Dockerfile
The docker file just sets the environment variables if you also need to generate Nether and End maps, installs necessary dependencies and the application itself and calls the `entrypoint.sh` script which enables cron, generate map and lastly the httpd-foreground.

### The `generate_map.sh` script
Starts off by printing the date and cleaning up the current world directory (dont worry this will not clean up your existing Minecraft world) and copies the working map (existing Minecraft world) to the current directory [1].  then runs the PapyrusCs application. This should log something in `/var/log/generate_map.log` so you could get back to checking it in the future.

[1] Why are we doing this? This is due to an issue I filed in https://github.com/mjungnickel18/papyruscs/issues/10 

## Other stuff
I am not an expert in Dockerizing services so please do cut me some slack if you're going to use this in your deployment. I provide no support whatsoever on this script and while its poorly written, it functions to perform what I need. 

I dont know how often the PapyrusCs team updates their code, so it is possible that the file being downloaded here is an old version. I will update it when I have the time.

Its is also possilbe that the script is suffering from an out of memory error. Check `dmesg` for any messages stating killed processes. Using the default settings, running on 0.5 CPU and 1.0 GB of RAM allocation, im still getting OOMed. I've generated an initial map with jpg 50 quality and the succeeding generation seems to be better.
