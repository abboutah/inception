FROM alpine:3.18.3

ARG PHP_VERSION=81

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-cgi \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-pdo_mysql \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-posix \
    php${PHP_VERSION}-gettext \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-simplexml \
    wget

#Move the adminer php file to the index.php file (located in var/www/html)
WORKDIR /var/www
#download adminer to this dir and call it index.php because the interpreter needs to feed the folder, and in the folder
#it looks for the index file.
# change file owner and group -R:recursive
#wget  package is a utility for downloading files from the internet.
RUN wget http://www.adminer.org/latest.php  -O /var/www/index.php && \
    chown -R root:root /var/www/

EXPOSE 8080

#I point the PHP interpreter at our working directory with the index file. So php will see our file and launch adminer.
CMD     [ "php", "-S", "[::]:8080", "-t", "/var/www" ]
