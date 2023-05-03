#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#

FROM php:5.6-fpm

MAINTAINER Rinku Rock <rinku.arnob@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# Update stretch repositories
RUN sed -i s/deb.debian.org/archive.debian.org/g /etc/apt/sources.list
RUN sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list
RUN sed -i '/stretch-updates/d' /etc/apt/sources.list

#
#--------------------------------------------------------------------------
# Software's Installation
#--------------------------------------------------------------------------
#
# Installing tools and PHP extentions using "apt", "docker-php", "pecl",
#

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
# 1. development packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  && apt-get install -y curl g++ git gettext sqlite3 supervisor unzip zip \
    libbz2-dev libc-client-dev libenchant-dev libfreetype6-dev libgmp-dev \
    libicu-dev libjpeg-dev libkrb5-dev libmcrypt-dev libpng-dev libreadline-dev \
    libpspell-dev libtidy-dev libxml2-dev libxslt-dev

# 2. start with base php config, then add extensions
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install bcmath bz2 calendar enchant exif gd gmp gettext \
    iconv imap intl mbstring mcrypt mysql mysqli opcache pcntl pdo_mysql pspell \
    shmop soap sockets sysvmsg sysvsem sysvshm tidy wddx xml xmlrpc xsl zip

#composer setup
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# xDebug installation
RUN yes | pecl install xdebug-2.5.5 \
  && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
  && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
  && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini


# RUN pecl install -o -f redis \
#     &&  rm -rf /tmp/pear \
#     &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini


#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
USER root
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default work directory
WORKDIR /var/www
