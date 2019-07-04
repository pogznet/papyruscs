FROM httpd

# For testing purposes only
# docker build -t papyruscs .
# docker run -d -p 8080:80 papyruscs
# check http://localhost:8080/

# The WorldName should be mounted as data (/MyWorld, ie /mnt/minecraft-bedrock/worlds/Bedrock)
# Copy the sample map into the image
COPY MyWorld /MyWorld 

RUN apt-get update -y
RUN apt-get install -y zlib1g-dev unzip libgdiplus libc6-dev wget

# Set the work directory
WORKDIR /papyruscs

# Get PapyrusCs
RUN wget https://github.com/mjungnickel18/papyruscs/releases/download/v0.3.5/papyruscs-dotnetcore-0.3.5-linux64.zip
RUN unzip papyruscs-dotnetcore-0.3.5-linux64.zip -d /papyruscs
RUN chmod +x /papyruscs/PapyrusCs

# Generate it to the htdoc root directory
RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 0
#RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 1
#RUN /papyruscs/PapyrusCs --world="/MyWorld/db" --output="/usr/local/apache2/htdocs/" --htmlfile="index.html" -d 2

# This would be under site.tld/map/index.html 
EXPOSE 80
CMD ["httpd-foreground"]