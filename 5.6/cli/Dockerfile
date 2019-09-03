FROM php:5.6-cli

LABEL \
	name="PHP 5.6 CLI" \
	image="mattiabasone/php" \
	tag="5.6-cli" \
	vendor="mattiabasone"

# Get repository and install wget and vim
RUN apt-get update && apt-get install --no-install-recommends -y \
        gnupg \
        wget \
        vim \
        git \
        unzip \
        && rm -rf /var/lib/apt/lists/*

# Add PostgreSQL repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
      apt-key add -

# Install PHP extensions deps
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        libpq-dev \
        libpq5 \
        postgresql-server-dev-9.5 \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zlib1g-dev \
        libicu-dev \
        libtidy-dev \
        libxml2-dev \
        g++ \
        unixodbc-dev \
        libxml2-dev \
        libaio-dev \
        libmemcached-dev \
        freetds-dev \
	    libssl-dev \
	    openssl \
	    openssh-client \
	    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/local/bin \
        --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu \
    && pecl install redis \
    && pecl install memcached-2.2.0 \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-install \
            bcmath \
            dom \
            iconv \
            mbstring \
            intl \
            mcrypt \
            gd \
            pgsql \
            mysqli \
            pdo_pgsql \
            pdo_mysql \
            pdo_dblib \
            soap \
            sockets \
            zip \
            pcntl \
            ftp \
            tidy \
            tokenizer \
            xml \
    && docker-php-ext-enable \
            redis \
            opcache \
            xdebug \
            zip

# Install PHPUnit
RUN curl -sS https://phar.phpunit.de/phpunit-5.phar -o /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

# Install PHP Code Sniffer
RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs

RUN curl -sS https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o /usr/local/bin/phpcbf \
    && chmod +x /usr/local/bin/phpcbf

# Envoy
RUN composer global require "laravel/envoy=~1.0"

# Clean repository
RUN apt-get clean && composer global clear-cache