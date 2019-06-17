FROM ubuntu:16.04

# Setup environment
ENV DEBIAN_FRONTEND noninteractive

# Update sources
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y dist-upgrade

RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get -y update

# install http  + php
RUN apt-get -y install --force-yes apache2 openssl vim bash-completion unzip

RUN apt-get -y install --force-yes php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-pgsql php7.0-curl php7.0-zip php7.0-gd php7.0-cli php7.0-mcrypt php7.0-opcache php7.0-json php7.0-bz2 php7.0-mbstring 

#RUN apt-get install -y apache2 vim bash-completion unzip
RUN mkdir -p /var/lock/apache2 /var/run/apache2


RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod expires
RUN a2enmod php7.0

# install supervisord

RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

#Time
ENV TW=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TW /etc/localtime && echo $TW > /etc/timezone
