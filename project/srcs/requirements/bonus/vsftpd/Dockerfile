FROM alpine:3.18.3

ARG FTP_USR \
    FTP_PWD

RUN apk update && apk upgrade && \
    apk add --no-cache vsftpd

#We need to create a user to connect to the server, and with the next layer we will do this. 
#We will set the home section to /var/www, where we will mount the section with our wp. 
#Let's not forget to add this user to the root group so that we can process the WordPress directory 
#(otherwise we simply won't have enough rights).
#-h: display help message and exit
#-D: changind the defualt value
#-s: The name of the user's login shell. The default is to leave this field blank, 
#which causes the system to select the default login shell specified by the SHELL variable in /etc/default/useradd, 
#or an empty string by default.
#chpasswd command is used to change password although passwd command can also do same. 
#But it changes the password of one user at a time so for multiple users chpasswd is used. 
RUN adduser -h /var/www -s /bin/false -D ${FTP_USR} && \
    echo "${FTP_USR}:${FTP_PWD}" | /usr/sbin/chpasswd && \
    adduser ${FTP_USR} root
#chroot:  allows you to build, install, and test software in an environment that is separated from your  operating system.
#local_enable: This directive tells vsftpd to allow local users to log in to the FTP server.
#write_enable: enable any form of FTP write command.
# Default umask for local users is 077. You may wish to change this to 022,
# if your users expect that (022 is used by most other ftpd's) 
RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_enable=YES|local_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#write_enable=YES|write_enable=YES|g"  /etc/vsftpd/vsftpd.conf && \
    sed -i "s|#local_umask=022|local_umask=007|g"  /etc/vsftpd/vsftpd.conf
#allow_writeable_chroot: This directive tells vsftpd to allow local users to have write access to their home directories.
#pasv_enable :the PASV method of obtaining a data connection.
## (Seccomp is a security mechanism that restricts the system calls available to a process)
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf &&\
    echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf && \
    echo 'pasv_enable=YES' >> /etc/vsftpd/vsftpd.conf

WORKDIR /var/www

EXPOSE 21

CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf" ]
