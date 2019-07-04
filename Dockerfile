FROM httpd

# TODO: 
# 	Add support for Nether and End
#	Run the generate map every hour
#	Using entrypoint takes forever before the health check starts maybe move it after cmd

# For testing purposes only
# docker build -t papyruscs .
# docker run -d -p 8080:80 -v E:/Bedrock:/MyWorld  papyruscs
# check http://localhost:8080/

# Set environment variables
#ENV LevelNether
#ENV LevelEnd

# The WorldName should be mounted as data (/MyWorld, ie /mnt/minecraft-bedrock/worlds/Bedrock)
# Copy the sample map into the image
#COPY MyWorld /MyWorld 

RUN apt-get update -y
RUN apt-get install -y zlib1g-dev unzip libgdiplus libc6-dev wget

# Set the work directory
WORKDIR /papyruscs

# Get PapyrusCs
RUN wget https://github.com/mjungnickel18/papyruscs/releases/download/v0.3.5/papyruscs-dotnetcore-0.3.5-linux64.zip
RUN unzip papyruscs-dotnetcore-0.3.5-linux64.zip -d /papyruscs
RUN chmod +x /papyruscs/PapyrusCs

# Lets copy the script to the target location
COPY generate_map.sh /usr/local/bin/generate_map.sh 
RUN chmod +x /usr/local/bin/generate_map.sh

# This would be under site.tld/map/index.html 
EXPOSE 80
CMD ["httpd-foreground"]

# Moved entrypoint so that the http would run first
RUN ["generate_map.sh"]