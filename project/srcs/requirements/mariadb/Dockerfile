FROM alpine:3.18.3

#Docker has two ways to pass environment variables to an image: via ARG and via ENV.
# ARG takes arguments passed to docker build or you can assign a value to it
# ENV creates an environment variable during build and runtime.
#Through ARG, those arguments are passed that will be used when building the image, and will not be used after it starts.
#Therefore, we will transfer all our secrets through the ARG, so that they do not hang around the already assembled image.
#Variables that will be in the environment of an already running container are passed through ENV. We will not use them for our tasks.
ARG DB_NAME \
    DB_USER \
    DB_PASS
#install mariadb and mariadb clien without caching
RUN apk update && apk add --no-cache mariadb mariadb-client
#send the output of echo to a file and the sed replaces lines in files by vakue
#tee - read from standard input and write to standard output and files
#sed - stream editor for filtering and transforming text -i edit files in-place instead of printing 
#to standard output. 
#-i: in place 
#s:replacinf or subtituting string
#g: replace all the occurence of the pattern in a line
# [mysqld]	 Options read by mysqld, which includes both MariaDB Server and MySQL Server.
#--skip-name-resolve	Uses IP addresses rather than host names when creating grant table entries. This option can be useful if your DNS does not work.
#The bind address is the IP address that MySQL uses to accept incoming connections. 
#You can disable the host name cache by starting the server with the --skip-host-cache option. 
#To clear the host name cache, issue a FLUSH HOSTS statement or execute the mysqladmin flush-hosts command.
#To disallow TCP/IP connections entirely, start mysqld with the --skip-networking option.
RUN mkdir /var/run/mysqld; \
    chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
      echo 'skip-name-resolve'; \
      echo 'bind-address=0.0.0.0'; \
    } | tee  /etc/my.cnf.d/docker.cnf; \
    sed -i "s|skip-networking|skip-networking=0|g" \
      /etc/my.cnf.d/mariadb-server.cnf
#mariadb-install-db initializes the MariaDB data directory and creates the system tables 
#in the mysql database, if they do not exist.
#--datadir:the path where database will be stored
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql
#open the mariadb port
EXPOSE 3306
#execute the script
COPY conf/create_db.sh .
RUN sh create_db.sh && rm create_db.sh
#ENTRYPOINT allows you to configure a container that will run as executable
#switch to the mysql user
#launch the database under this user
USER mysql
CMD ["/usr/bin/mysqld", "--skip-log-error"]
