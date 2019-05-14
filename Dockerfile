FROM ubuntu:16.04

RUN mkdir -p /var/www/log && chown www-data:www-data /var/www/log
RUN chown  -R www-data:www-data /var/www

#Tom script
RUN apt-get update && apt-get upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y install cron
RUN apt-get -y install apache2 apache2-bin
RUN apache2ctl start
RUN apt-get -y install python-software-properties
RUN apt-get -y install software-properties-common
RUN apt-get -y install locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get -y update
RUN apt-get -y install openssl php7.1 libapache2-mod-php7.1 php7.1-mysql php7.1-pgsql php7.1-curl php7.1-zip php7.1-gd php7.1-cli php7.1-mcrypt php7.1-opcache php7.1-json php7.1-bz2 php7.1-mbstring php7.1-cli php7.1-dev php7.1-xml php-pear libpq-dev libevent-dev make git build-essential libnghttp2-dev vim bash-completion unzip
RUN apt-get -y install expect tcl
COPY pecl_event.sh /root/
RUN expect /root/pecl_event.sh
RUN echo extension=event.so >> /etc/php/7.1/cli/conf.d/30-event.ini
RUN cd / \
&& git clone https://github.com/swoole/swoole-src.git \
&& cd swoole-src/ \
&& /usr/bin/phpize \
&& ./configure --enable-sockets --enable-openssl --enable-http2 --enable-mysqlnd --enable-coroutine-postgresql \
&& make \
&& make install \
&& echo "extension=swoole.so" >> /etc/php/7.1/cli/php.ini \
RUN rm -Rf /swoole-src

RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2enmod deflate
RUN a2enmod expires
RUN service apache2 restart

#Time
ENV TW=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TW /etc/localtime && echo $TW > /etc/timezone
