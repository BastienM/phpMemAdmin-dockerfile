# To build the image : docker build -t phpmemadmin .
 
FROM php:5.6-apache

MAINTAINER Bastien MENNESSON <bastien.mennesson@d2-si.eu>

ENV AWS_LIBMEMCACHED_URL="https://github.com/awslabs/aws-elasticache-cluster-client-libmemcached.git" \
    LIBMEMCACHED_PATH="/usr/include/libmemcached"    

# Copying configuration files
ADD rootfs/ /

# Installing needed system libraries
RUN apt-get update && \
    apt-get install -y git unzip wget zlib1g-dev libevent-dev gcc g++ make autoconf libsasl2-dev

WORKDIR /tmp

# Installing AWS MemCached SDK dependencies
RUN git clone $AWS_LIBMEMCACHED_URL && \
    cd aws-elasticache-cluster-client-libmemcached && \
    touch configure.ac aclocal.m4 configure Makefile.am Makefile.in && \
    mkdir BUILD && \
    cd BUILD && \
    ../configure --prefix=$LIBMEMCACHED_PATH --with-pic && \
    make && \
    make install    

# Installing PHP extensions
RUN docker-php-source extract && \
    docker-php-ext-install zip && \
    docker-php-ext-enable amazon-elasticache-cluster-client && \
    docker-php-source delete

# Updating Apache2's vhosts
RUN a2dissite 000-default.conf && \
    a2ensite phpMemAdmin.conf

# Downloading Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Installing phpMemAdmin
RUN composer install --quiet --no-interaction --no-scripts && \
    cp -R vendor/clickalicious/phpmemadmin/app . && \
    cp -R vendor/clickalicious/phpmemadmin/bin . && \
    cp -R vendor/clickalicious/phpmemadmin/web . && \
    chown -R www-data:www-data .

ENTRYPOINT ["/entrypoint.sh"]

CMD ["apache2-foreground"]
