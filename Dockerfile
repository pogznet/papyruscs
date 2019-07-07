FROM httpd

# TODO: 
# 	DONE - Add support for Nether and End
#	DONE - Run the generate map every hour

# For testing purposes only
# docker build -t papyruscs .
# docker run -d -p 8080:80 -v /your/minecraft/world/directory:/MyWorld -v /your/http/root/directory:/usr/local/apache2/htdocs/  papyruscs
# check http://localhost:8080/

# IMPORTANT NOTE: 
# /usr/local/apache2/htdocs/ must be pre-seeded with an existing generated map
# 	for any container failure, this can be a volume mounted as /usr/local/apache2/htdocs/

# Set environment variables
ENV LEVEL_NETHER = 0
ENV LEVEL_END = 0
ENV CONFIG_THREADS = 16
ENV CONFIG_OUTFILE = png
ENV CONFIG_QUALITY = -1

# The WorldName should be mounted as data (/MyWorld, ie /mnt/minecraft-bedrock/worlds/Bedrock)
# Copy the sample map into the image
#COPY MyWorld /MyWorld 

RUN apt-get update -y
RUN apt-get install -y zlib1g-dev unzip libgdiplus libc6-dev wget cron nano

# Set the work directory
WORKDIR /papyruscs

# Get PapyrusCs
RUN wget https://github.com/mjungnickel18/papyruscs/releases/download/v0.3.6/papyruscs-dotnetcore-0.3.6-linux64.zip
RUN unzip papyruscs-dotnetcore-0.3.6-linux64.zip -d /papyruscs
RUN chmod +x /papyruscs/PapyrusCs

# Copy the script into the target location
COPY generate_map.sh /usr/local/bin/generate_map.sh 
RUN chmod +x /usr/local/bin/generate_map.sh

# Copy the entrypoint.sh script 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy the cronjob file and install
# 	https://stackoverflow.com/questions/35722003/cron-job-not-auto-runs-inside-a-docker-container
COPY root /etc/cron.d/root
RUN chmod 0600 /etc/cron.d/root
RUN crontab /etc/cron.d/root

# This would be under site.tld/map/index.html 
EXPOSE 80
ENTRYPOINT ["entrypoint.sh"]