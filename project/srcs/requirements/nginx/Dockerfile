#Dockerfile is responsible for the configuration. It specifies a set of software that we want to deploy inside this container.
#FROM: creates a layer from the alpine Docker image
#FROM:latest assigned to the latest versions of alpine in the dockerhub
#FROM: install alpine in Image Environment Blueprint
#FROM: Build this image from the specified image
FROM alpine:3.18.3
#RUN: will execute any command in a shell inside the container environment
#update apk (Same as apk in debian) and install nginx without saving the sources in the cache
RUN	apk update && apk upgrade && apk add --no-cache nginx
#EXPOSE: The container listens on the specified network ports at runtime, you can specify tcp(default) or udp
EXPOSE 443
#COPY: copies files or directories from src and adds them to the filesysytem of the container at the path dest
#while RUN is excuted in the container, COPY is executed on the host
#WORKDIR:sets the working directory for all following commands -> cd ..
#CMD: The instrucction that is to be executed when a docker container starts, one CMD per Dockerfile
#This way we run nginx directly and not in daemon mode.
#Daemon mode is a launch mode in which the application starts in the background or, in Windows parlance, as a service. 
#For ease of debugging, we disable this mode and receive all nginx logs directly into the tty of the container.
#-g: set global configuratoin directives
CMD ["nginx", "-g", "daemon off;"]




