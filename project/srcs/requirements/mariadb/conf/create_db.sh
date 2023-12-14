#!bin/sh

#check whether mysql is running, if not then it start
#-d : file 'directory' exists and is a directory.
#-f: file 'regularfile' exists and is a regular file.
if [ ! -d "/var/lib/mysql/mysql" ]; then

	#chown - change file owner and group, -R, --recursive operate on files and directories recursively
        chown -R mysql:mysql /var/lib/mysql

        #  initializes the MariaDB data directory and creates the system tables in the mysql database.
	#--basedir=path	The path to the MariaDB installation directory.
	#--datadir=path The path to the MariaDB data directory.
	#--user=user_name The login user name to use for running mysqld. 
	#Files and directories created by mysqld will be owned by this user. You must be root to use this option.
	# By default, mysqld runs using your current login name and files and directories 
	#that it creates will be owned by you.
        #--rpm	For internal use. This option is used by RPM files during the MariaDB installation process.
	#the RPM file extension is a Red Hat package manager file that's used to store installation packages on Linux operating systems.
	# These files provide an easy way for software to be distributed, installed, upgraded,
	# and removed since they're "packaged" in one place
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

#        tfile=`mktemp`
#check in case something bad happens
 #       if [ ! -f "$tfile" ]; then
  #             return 1
   #     fi
fi
#check whether a database named wordpress exist
#of course we don't have it
if [ ! -d "/var/lib/mysql/wordpress" ]; then
#create sql code to create the database in the file for sql queries 
#the code uses env var that will pass from the env file
#execute the code and delete extra configuration file, covering our  traces
        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
#Modify an existing account
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT}';
CREATE DATABASE ${DB_NAME};
#allowing remote acces from any other computer on the network
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
#set privilieges
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
#save changes
FLUSH PRIVILEGES;
EOF
        # run init.sql
	#  --bootstrap :This option is used by the mysql_install_db script to create the MySQL 
	#privilege tables without having to start a full MySQL server.
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        rm -f /tmp/create_db.sql
fi
