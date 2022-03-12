FROM php:8.1-fpm
COPY composer.json /var/www/
WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    libzip-dev \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl \
    libssh2-1-dev libssh2-1 \
    libmcrypt-dev \
    libpq-dev \
    libicu-dev \
                 && docker-php-ext-configure intl \
                 && docker-php-ext-install intl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#RUN gmp gmp-dev && \
#  docker-php-ext-install gmp && \
#  apk del --no-cache gmp-dev

#RUN docker-php-ext-install gmp
RUN docker-php-ext-install bcmath
RUN pecl install redis \
    && docker-php-ext-enable redis
RUN docker-php-ext-install pdo_mysql pdo_pgsql exif pcntl gd zip calendar
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install nodejs -yq

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY . /var/www

COPY --chown=www:www . /var/www

USER www

EXPOSE 9000
EXPOSE 6001
CMD ["php-fpm"]
