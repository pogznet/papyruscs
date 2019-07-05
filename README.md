# PapyrusCs Docker Image

## Pre-requisites
- You need to generate the HTML files and the respective files at least ONCE. This removes the burden on the Docker image to do the first generation. 
- You need to be able to mount your Minecraft map data so that this would be read by the generator

## What you need to run

```
docker run -d -p 8080:80 \
    -v /your/minecraft/world/directory:/MyWorld \
    -v /your/http/root/directory:/usr/local/apache2/htdocs/ \
    papyruscs
```

## Under the hood

### The Dockerfile
The docker file just sets the environment variables if you also need to generate Nether and End maps, installs necessary dependencies and the application itself and deploys the `generate_map.sh` script along with adding it as an hourly cronjob. 

### The `generate_map.sh` script
Starts off by printing the date and cleaning up the current world directory (dont worry this will not clean up your existing Minecraft world) and copies the working map (existing Minecraft world) to the current directory [1].  then runs the PapyrusCs application. This should log something in `/var/log/papyrus_*.log` so you could get back to checking it in the future.

[1] Why are we doing this? This is due to an issue I filed in https://github.com/mjungnickel18/papyruscs/issues/10 

## Other stuff
I am not an expert in Dockerizing services so please do cut me some slack if you're going to use this in your deployment. I provide no support whatsoever on this script and while its poorly written, it functions to perform what I need. 

I dont know how often the PapyrusCs team updates their code, so it is possible that the file being downloaded here is an old version. I will update it when I have the time.