FROM httpd

# docker build . -t latest

# docker run -name papyruscs -v /Bedrock:/data -p 8080:80 

# The WorldName should be mounted as data (worlds/WorldName, ie /mnt/minecraft-bedrock/worlds/Bedrock)
VOLUME /data

RUN apt-get update -y
RUN apt-get install -y zlib1g-dev unzip libgdiplus libc6-dev wget

# Get PapyrusCs
RUN cd ~
RUN wget https://github.com/mjungnickel18/papyruscs/releases/download/v0.3.5/papyruscs-dotnetcore-0.3.5-linux64.zip
RUN mkdir papyruscs
RUN unzip papyruscs-dotnetcore-0.3.5-linux64.zip -d ~/papyruscs
RUN chmod +x ~/papyruscs/PapyrusCs

#RUN cd /var/www/html 
RUN mkdir /data/
RUN mkdir /data/db
RUN ~/papyruscs/PapyrusCs --world="/data/db" --output="/var/www/html"

# This would be under site.tld/map/map.html 
EXPOSE 80
CMD ["httpd-foreground"]